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

const Entry = struct {
    node: *TreeNode,
    level: usize,
};

fn solution(alloc: std.mem.Allocator, root: ?*TreeNode) ![]f32 {
    var q = std.ArrayList(Entry).init(alloc);
    defer q.deinit();

    var mp = std.AutoHashMap(usize, i32).init(alloc);
    defer mp.deinit();

    var freq = std.AutoHashMap(usize, usize).init(alloc);
    defer freq.deinit();

    var result = std.ArrayList(f32).init(alloc);
    defer result.deinit();

    if (root) |n| {
        try q.append(Entry{
            .node = n,
            .level = 0,
        });
    }

    var max_level: usize = 0;

    while (q.items.len > 0) {
        const curr = q.pop();
        if (curr == null) {
            break;
        }

        max_level = @max(max_level, curr.?.level);

        try mp.put(curr.?.level, (mp.get(curr.?.level) orelse 0) + curr.?.node.val);
        try freq.put(curr.?.level, (freq.get(curr.?.level) orelse 0) + 1);

        if (curr.?.node.left) |n| {
            try q.append(Entry{ .level = curr.?.level + 1, .node = n });
        }

        if (curr.?.node.right) |n| {
            try q.append(Entry{ .level = curr.?.level + 1, .node = n });
        }
    }

    for (0..max_level + 1) |level| {
        const count = freq.get(level) orelse 1;
        const sum = mp.get(level) orelse 0;
        const avg = @as(f32, @floatFromInt(sum)) / @as(f32, @floatFromInt(count));

        try result.append(avg);
    }

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 3);
    const b = try TreeNode.init(alloc, 9);
    var c = try TreeNode.init(alloc, 20);
    const d = try TreeNode.init(alloc, 15);
    const e = try TreeNode.init(alloc, 7);

    a.left = b;
    a.right = c;
    c.left = d;
    c.right = e;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);

    const sol = try solution(alloc, a);
    defer alloc.free(sol);

    try expect(@abs(sol[0] - 3.00) <= 1e-7);
    try expect(@abs(sol[1] - 14.5) <= 1e-7);
    try expect(@abs(sol[2] - 11.0) <= 1e-7);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var a = try TreeNode.init(alloc, 3);
    var b = try TreeNode.init(alloc, 9);
    const c = try TreeNode.init(alloc, 20);
    const d = try TreeNode.init(alloc, 15);
    const e = try TreeNode.init(alloc, 7);

    a.left = b;
    a.right = c;
    b.left = d;
    b.right = e;

    defer alloc.destroy(a);
    defer alloc.destroy(b);
    defer alloc.destroy(c);
    defer alloc.destroy(d);
    defer alloc.destroy(e);

    const sol = try solution(alloc, a);
    defer alloc.free(sol);

    try expect(@abs(sol[0] - 3.00) <= 1e-7);
    try expect(@abs(sol[1] - 14.5) <= 1e-7);
    try expect(@abs(sol[2] - 11.0) <= 1e-7);
}
