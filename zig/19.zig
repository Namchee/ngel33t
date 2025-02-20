const std = @import("std");

const Node = struct {
    val: i32,
    next: ?*Node,

    pub fn init(alloc: std.mem.Allocator, val: i32) !*Node {
        const node = try alloc.create(Node);
        node.val = val;
        node.next = null;

        return node;
    }
};

fn solution(head: ?*Node, n: usize) !?*Node {
    var a: ?*Node = head;
    var b: ?*Node = head;
    var prev: ?*Node = null;

    for (0..n) |_| {
        if (a == null) {
            return head;
        }

        a = a.?.next;
    }

    while (a) |node| {
        prev = b;
        a = node.next;
        b = b.?.next;
    }

    if (b == head) {
        return head.?.next;
    }

    if (prev) |node| {
        node.next = b.?.next;

        return head;
    }

    return null;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const content = [_]i32{ 1, 2, 3, 4, 5 };
    const sentinel: ?*Node = try Node.init(alloc, -1);

    var runner: ?*Node = sentinel;
    for (content) |num| {
        const node = try Node.init(alloc, num);
        defer alloc.destroy(node);
        runner.?.next = node;
        runner = runner.?.next;
    }

    const sol = try solution(sentinel.?.next, 2);

    const expected = [_]i32{ 1, 2, 3, 5 };
    runner = sol;

    for (expected) |num| {
        try expect(num == runner.?.val);
        runner = runner.?.next;
    }

    if (sentinel) |node| {
        alloc.destroy(node);
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const content = [_]i32{1};
    const sentinel: ?*Node = try Node.init(alloc, -1);

    var runner: ?*Node = sentinel;
    for (content) |num| {
        const node = try Node.init(alloc, num);
        defer alloc.destroy(node);
        runner.?.next = node;
        runner = runner.?.next;
    }

    const sol = try solution(sentinel.?.next, 1);

    try expect(sol == null);

    if (sentinel) |node| {
        alloc.destroy(node);
    }
}

test "test case #3" {
    const alloc = std.testing.allocator;

    const content = [_]i32{ 1, 2 };
    const sentinel: ?*Node = try Node.init(alloc, -1);

    var runner: ?*Node = sentinel;
    for (content) |num| {
        const node = try Node.init(alloc, num);
        defer alloc.destroy(node);
        runner.?.next = node;
        runner = runner.?.next;
    }

    const sol = try solution(sentinel.?.next, 1);

    const expected = [_]i32{1};
    runner = sol;

    for (expected) |num| {
        try expect(num == runner.?.val);
        runner = runner.?.next;
    }

    if (sentinel) |node| {
        alloc.destroy(node);
    }
}
