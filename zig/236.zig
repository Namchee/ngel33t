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

fn solution(root: ?*TreeNode, p: ?*TreeNode, q: ?*TreeNode) ?*TreeNode {
    if (root == null or root == p or root == q) {
        return root;
    }

    const left = solution(root.?.left, p, q);
    const right = solution(root.?.right, p, q);

    if (left != null and right != null) {
        return root;
    }

    return left orelse right;
}

const except = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 3);
    var b = try TreeNode.init(alloc, 5);
    const c = try TreeNode.init(alloc, 6);
    var d = try TreeNode.init(alloc, 2);
    const e = try TreeNode.init(alloc, 7);
    const f = try TreeNode.init(alloc, 4);
    var g = try TreeNode.init(alloc, 1);
    const h = try TreeNode.init(alloc, 0);
    const i = try TreeNode.init(alloc, 6);

    a.left = b;
    b.left = c;
    b.right = d;
    d.left = e;
    d.right = f;
    a.right = g;
    g.left = h;
    g.right = i;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);
    defer alloc.destroy(f);
    defer alloc.destroy(g);
    defer alloc.destroy(h);
    defer alloc.destroy(i);

    const sol = solution(a, b, g);

    try except(sol == a);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 3);
    var b = try TreeNode.init(alloc, 5);
    const c = try TreeNode.init(alloc, 6);
    var d = try TreeNode.init(alloc, 2);
    const e = try TreeNode.init(alloc, 7);
    const f = try TreeNode.init(alloc, 4);
    var g = try TreeNode.init(alloc, 1);
    const h = try TreeNode.init(alloc, 0);
    const i = try TreeNode.init(alloc, 6);

    a.left = b;
    b.left = c;
    b.right = d;
    d.left = e;
    d.right = f;
    a.right = g;
    g.left = h;
    g.right = i;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);
    defer alloc.destroy(f);
    defer alloc.destroy(g);
    defer alloc.destroy(h);
    defer alloc.destroy(i);

    const sol = solution(a, b, f);

    try except(sol == b);
}
