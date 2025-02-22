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

fn has_sum(node: ?*TreeNode, target: i32, curr: i32) bool {
    if (node == null) {
        return curr == target;
    }

    return has_sum(node.?.left, target, curr + node.?.val) or has_sum(node.?.right, target, curr + node.?.val);
}

fn solution(root: ?*TreeNode, target: i32) bool {
    return has_sum(root, target, 0);
}

const except = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 1);
    const b = try TreeNode.init(alloc, 2);
    const c = try TreeNode.init(alloc, 3);

    a.left = b;
    a.right = c;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);

    const sol = solution(a, 5);

    try except(!sol);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 5);
    var b = try TreeNode.init(alloc, 4);
    var c = try TreeNode.init(alloc, 11);
    const d = try TreeNode.init(alloc, 7);
    const e = try TreeNode.init(alloc, 2);
    var f = try TreeNode.init(alloc, 8);
    const g = try TreeNode.init(alloc, 13);
    var h = try TreeNode.init(alloc, 4);
    const i = try TreeNode.init(alloc, 1);

    a.left = b;
    b.left = c;
    c.left = d;
    c.right = e;
    a.right = f;
    f.left = g;
    f.right = h;
    h.right = i;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);
    defer alloc.destroy(f);
    defer alloc.destroy(g);
    defer alloc.destroy(h);
    defer alloc.destroy(i);

    const sol = solution(a, 22);

    try except(sol);
}
