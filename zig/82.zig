const std = @import("std");

const Node = struct {
    val: i32,
    next: ?*Node,

    pub fn init(alloc: std.mem.Allocator, val: i32) !*Node {
        var node = try alloc.create(Node);
        node.val = val;
        node.next = null;

        return node;
    }
};

fn solution(alloc: std.mem.Allocator, head: ?*Node) !?*Node {
    var mp = std.AutoHashMap(i32, i32).init(alloc);
    defer mp.deinit();

    var runner: ?*Node = head;
    while (runner) |node| {
        const val = (mp.get(node.val) orelse 0) + 1;

        try mp.put(node.val, val);

        runner = runner.?.next;
    }

    const prev = try Node.init(alloc, -1);
    defer alloc.destroy(prev);
    var last: ?*Node = prev;

    runner = head;

    while (runner) |node| {
        const next = node.next;
        const freq = mp.get(node.val);
        if (freq == 1) {
            last.?.next = node;
            last = last.?.next;
            last.?.next = null;
        } else {
            alloc.destroy(node);
        }

        runner = next;
    }

    return prev.next;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const content = [_]i32{ 1, 2, 3, 3, 4, 4, 5 };
    var sentinel: ?*Node = try Node.init(alloc, -1);
    defer {
        while (sentinel) |node| {
            const next = node.next;
            alloc.destroy(node);
            sentinel = next;
        }
    }

    var runner = sentinel;
    for (content) |num| {
        runner.?.next = try Node.init(alloc, num);
        runner = runner.?.next;
    }

    const expected = [_]i32{ 1, 2, 5 };
    const sol = try solution(alloc, sentinel.?.next);

    runner = sol;

    for (expected) |num| {
        try expect(num == runner.?.val);
        runner = runner.?.next;
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const content = [_]i32{ 1, 1, 1, 2, 3 };
    const sentinel: ?*Node = try Node.init(alloc, -1);

    var runner = sentinel;
    for (content) |num| {
        runner.?.next = try Node.init(alloc, num);
        runner = runner.?.next;
    }

    const expected = [_]i32{ 2, 3 };
    const sol = try solution(alloc, sentinel.?.next);

    runner = sol;

    for (expected) |num| {
        try expect(num == runner.?.val);
        runner = runner.?.next;
    }

    runner = sol;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }

    if (sentinel) |node| {
        alloc.destroy(node);
    }
}
