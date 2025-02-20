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

fn solution(root: ?*TreeNode) usize {
    if (root == null) {
        return 0;
    }

    return 1 + @max(solution(root.?.left), solution(root.?.right));
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var root = try TreeNode.init(alloc, 3);
    const a = try TreeNode.init(alloc, 9);
    var b = try TreeNode.init(alloc, 20);
    const c = try TreeNode.init(alloc, 15);
    const d = try TreeNode.init(alloc, 7);

    defer alloc.destroy(root);
    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);

    root.left = a;
    root.right = b;
    b.left = c;
    b.right = d;

    const sol = solution(root);

    try expect(sol == 3);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var root = try TreeNode.init(alloc, 1);
    const a = try TreeNode.init(alloc, 2);

    defer alloc.destroy(root);
    defer alloc.destroy(a);

    root.right = a;

    const sol = solution(root);

    try expect(sol == 2);
}
