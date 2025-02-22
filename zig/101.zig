const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode = null,
    right: ?*TreeNode = null,

    pub fn init(alloc: std.mem.Allocator, val: i32) !*TreeNode {
        const node = try alloc.create(TreeNode);
        node.val = val;

        return node;
    }
};

fn solution(a: ?*TreeNode, b: ?*TreeNode) bool {
    if (a == null and b == null) {
        return true;
    }

    if (a == null or b == null) {
        return false;
    }

    const nodeA = a.?;
    const nodeB = b.?;

    return nodeA.val == nodeB.val and solution(nodeA.left, nodeB.left) and solution(nodeA.right, nodeB.right);
}

const except = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 1);
    const b = try TreeNode.init(alloc, 2);
    var c = try TreeNode.init(alloc, 1);
    const d = try TreeNode.init(alloc, 2);

    a.left = b;
    c.right = d;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);

    const sol = solution(a, b);

    try except(!sol);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 1);
    const b = try TreeNode.init(alloc, 2);
    const c = try TreeNode.init(alloc, 3);

    var d = try TreeNode.init(alloc, 1);
    const e = try TreeNode.init(alloc, 2);
    const f = try TreeNode.init(alloc, 3);

    a.left = b;
    a.right = c;

    d.left = e;
    d.right = f;

    defer alloc.destroy(e);
    defer alloc.destroy(f);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(a);
    defer alloc.destroy(d);

    const sol = solution(a, d);

    try except(sol);
}
