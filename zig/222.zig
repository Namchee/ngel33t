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

fn get_height(node: ?*TreeNode) i32 {
    if (node == null) {
        return -1;
    }

    return 1 + get_height(node.?.left);
}

fn solution(root: ?*TreeNode) i32 {
    const height = get_height(root);

    if (height < 0) {
        return 0;
    }

    const height_r = get_height(root.?.right);

    if (height_r == height - 1) {
        return (@as(i32, 1) << @intCast(height)) + solution(root.?.right);
    }

    return (@as(i32, 1) << @intCast(height - 1)) + solution(root.?.left);
}

const except = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 1);
    var b = try TreeNode.init(alloc, 2);
    const c = try TreeNode.init(alloc, 3);
    const d = try TreeNode.init(alloc, 4);
    const e = try TreeNode.init(alloc, 5);
    const f = try TreeNode.init(alloc, 6);

    a.left = b;
    b.left = d;
    b.right = e;
    a.right = c;
    c.left = f;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);
    defer alloc.destroy(f);

    const sol = solution(a);

    try except(sol == 6);
}

test "test case #2" {
    const sol = solution(null);

    try except(sol == 0);
}

test "test case #3" {
    const alloc = std.testing.allocator;

    const a = try TreeNode.init(alloc, 1);

    defer alloc.destroy(a);

    const sol = solution(a);

    try except(sol == 1);
}
