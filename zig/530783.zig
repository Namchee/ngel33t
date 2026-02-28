const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode = null,
    right: ?*TreeNode = null,
};

const State = struct {
    prev: i32 = -1,
    best: i32 = std.math.maxInt(i32),

    fn traverse(self: *State, node: ?*TreeNode) void {
        if (node) |n| {
            self.traverse(n.left);
            if (self.prev != -1) {
                self.best = @min(self.best, @abs(n.val - self.prev));
            }
            self.prev = n.val;

            self.traverse(n.right);
        }
    }
};

fn solution(node: ?*TreeNode) i32 {
    var state = State{};

    state.traverse(node);

    return state.best;
}

const expect = std.testing.expect;

test "test case #1" {
    var c = TreeNode{ .val = 1 };
    var d = TreeNode{ .val = 3 };

    var b = TreeNode{ .val = 2, .left = &c, .right = &d };

    var e = TreeNode{ .val = 6 };

    var a = TreeNode{ .val = 4, .left = &b, .right = &e };

    const expected = 1;

    const sol = solution(&a);

    try expect(sol == expected);
}

test "test case #2" {
    var c = TreeNode{ .val = 12 };
    var d = TreeNode{ .val = 49 };

    var b = TreeNode{ .val = 48, .left = &c, .right = &d };

    var e = TreeNode{ .val = 0 };

    var a = TreeNode{ .val = 4, .left = &e, .right = &b };

    const expected = 1;

    const sol = solution(&a);

    try expect(sol == expected);
}
