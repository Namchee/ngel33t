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

fn solution(alloc: std.mem.Allocator, a: *Node, b: *Node) !void {
    var runner_a: ?*Node = a;
    var runner_b: ?*Node = b;

    var carry: i32 = 0;

    while (runner_a != null or runner_b != null) {
        var sum: i32 = carry;

        if (runner_a) |node| {
            sum += node.val;
        }

        if (runner_b) |node| {
            sum += node.val;
            runner_b = node.next;
        }

        carry = @divFloor(sum, 10);
        sum = @rem(sum, 10);

        runner_a.?.val = sum;

        if (runner_a.?.next != null) {
            runner_a = runner_a.?.next;
        } else {
            break;
        }
    }

    if (carry > 0) {
        runner_a.?.next = try Node.init(alloc, 1);
    }
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try Node.init(alloc, 2);
    var a_a = try Node.init(alloc, 4);
    const a_b = try Node.init(alloc, 3);
    a.next = a_a;
    a_a.next = a_b;

    var b = try Node.init(alloc, 5);
    var b_a = try Node.init(alloc, 6);
    const b_b = try Node.init(alloc, 4);
    b.next = b_a;
    b_a.next = b_b;

    try solution(alloc, a, b);
    const expected = [_]i32{ 7, 0, 8 };

    var runner: ?*Node = a;

    for (expected) |num| {
        try expect(runner.?.val == num);
        runner = runner.?.next;
    }

    // cleanup
    runner = a;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }

    runner = b;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const a = try Node.init(alloc, 0);
    const b = try Node.init(alloc, 0);

    try solution(alloc, a, b);
    const expected = [_]i32{0};

    var runner: ?*Node = a;

    for (expected) |num| {
        try expect(runner.?.val == num);
        runner = runner.?.next;
    }

    // cleanup
    runner = a;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }

    runner = b;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }
}

test "test case #3" {
    const alloc = std.testing.allocator;

    const content_a = [_]i32{ 9, 9, 9, 9, 9, 9, 9 };
    const sentinel = try Node.init(alloc, -1);
    var a = sentinel;
    var runner: ?*Node = a;

    for (content_a) |num| {
        runner.?.next = try Node.init(alloc, num);
        runner = runner.?.next;
    }

    a = a.next.?;

    const content_b = [_]i32{ 9, 9, 9, 9 };
    var b = sentinel;
    runner = b;

    for (content_b) |num| {
        runner.?.next = try Node.init(alloc, num);
        runner = runner.?.next;
    }

    b = b.next.?;

    try solution(alloc, a, b);
    const expected = [_]i32{ 8, 9, 9, 9, 0, 0, 0, 1 };

    runner = a;

    for (expected) |num| {
        try expect(runner.?.val == num);
        runner = runner.?.next;
    }

    // cleanup
    runner = a;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }

    runner = b;
    while (runner) |node| {
        const next = node.next;
        alloc.destroy(node);
        runner = next;
    }

    alloc.destroy(sentinel);
}
