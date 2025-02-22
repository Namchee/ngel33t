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

fn traverse(node: ?*TreeNode, list: *std.ArrayList(i32)) !void {
    if (node) |n| {
        try traverse(n.left, list);
        try list.append(n.val);
        try traverse(n.right, list);
    }
}

fn solution(alloc: std.mem.Allocator, root: ?*TreeNode) !bool {
    var list = std.ArrayList(i32).init(alloc);
    defer list.deinit();

    try traverse(root, &list);

    for (0..list.items.len / 2) |idx| {
        const opp = list.items.len - 1 - idx;

        if (list.items[idx] != list.items[opp]) {
            return false;
        }
    }

    return true;
}

const except = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 1);
    var b = try TreeNode.init(alloc, 2);
    const c = try TreeNode.init(alloc, 3);
    const d = try TreeNode.init(alloc, 4);

    var e = try TreeNode.init(alloc, 2);
    const f = try TreeNode.init(alloc, 4);
    const g = try TreeNode.init(alloc, 3);

    a.left = b;
    b.left = c;
    b.right = d;

    a.right = e;
    e.left = f;
    e.right = g;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);
    defer alloc.destroy(f);
    defer alloc.destroy(g);

    const sol = try solution(alloc, a);

    try except(sol);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 1);
    var b = try TreeNode.init(alloc, 2);
    const c = try TreeNode.init(alloc, 3);

    var d = try TreeNode.init(alloc, 2);
    const e = try TreeNode.init(alloc, 3);

    a.left = b;
    b.right = c;
    a.right = d;
    d.right = e;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);

    const sol = try solution(alloc, a);

    try except(!sol);
}
