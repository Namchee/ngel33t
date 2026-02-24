const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode = null,
    right: ?*TreeNode = null,
};

fn solution(node: ?*TreeNode) i32 {
    return traverse(node, 0);
}

fn traverse(node: ?*TreeNode, curr: i32) i32 {
    if (node == null) {
        return 0;
    }

    const acc = (curr << 1) | node.?.val;

    if (node.?.left == null and node.?.right == null) {
        return acc;
    }

    return traverse(node.?.left, acc) + traverse(node.?.right, acc);
}

const expect = std.testing.expect;

test "test case #1" {
    var a = TreeNode{
        .val = 0,
    };
    var b = TreeNode{
        .val = 1,
    };
    var c = TreeNode{
        .val = 0,
        .left = &a,
        .right = &b,
    };
    var d = TreeNode{
        .val = 0,
    };
    var e = TreeNode{
        .val = 1,
    };
    var f = TreeNode{
        .val = 1,
        .left = &d,
        .right = &e,
    };
    var root = TreeNode{ .val = 1, .left = &c, .right = &f };

    const expected = 22;
    const sol = solution(&root);

    try expect(sol == expected);
}

test "test case #2" {
    var root = TreeNode{ .val = 0 };

    const expected = 0;
    const sol = solution(&root);

    try expect(sol == expected);
}
