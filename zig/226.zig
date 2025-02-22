const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode,
    right: ?*TreeNode,

    pub fn init(alloc: std.mem.Allocator, val: i32) !*TreeNode {
        const node = try alloc.create(TreeNode);
        node.val = val;
        node.left = null;
        node.right = null;

        return node;
    }
};

fn solution(node: ?*TreeNode) void {
    if (node) |n| {
        const temp = n.left;
        n.left = n.right;
        n.right = temp;

        solution(n.left);
        solution(n.right);
    }
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 2);
    const b = try TreeNode.init(alloc, 1);
    const c = try TreeNode.init(alloc, 3);

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);

    a.left = b;
    a.right = c;

    solution(a);

    try expect(a.left.?.val == 3);
    try expect(a.right.?.val == 1);
}

test "test case #2" {
    // const alloc = std.testing.allocator;
}
