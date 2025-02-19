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

fn solution(alloc: std.mem.Allocator, a: ?*Node, b: ?*Node) !?*Node {
    var runner_a: ?*Node = a;
    var runner_b: ?*Node = b;

    const head: ?*Node = try Node.init(alloc, -1);
    var tail: ?*Node = head;

    while (runner_a != null or runner_b != null) {
        if (runner_b == null) {
            tail.?.next = runner_a;
            break;
        }

        if (runner_a == null) {
            tail.?.next = runner_b;
            break;
        }

        if (runner_a.?.val <= runner_b.?.val) {
            const next = runner_a.?.next;
            tail.?.next = runner_a;
            runner_a = next;
        } else {
            const next = runner_b.?.next;
            tail.?.next = runner_b;
            runner_b = next;
        }

        tail = tail.?.next;
    }

    const result = head.?.next;
    if (head) |node| {
        alloc.destroy(node);
    }
    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var a = try Node.init(alloc, 1);
    var b = try Node.init(alloc, 2);
    const c = try Node.init(alloc, 4);
    var d = try Node.init(alloc, 1);
    var e = try Node.init(alloc, 3);
    const f = try Node.init(alloc, 4);

    a.next = b;
    b.next = c;

    d.next = e;
    e.next = f;

    var sol = try solution(alloc, a, d);
    var orig = sol;

    defer {
        while (orig) |node| {
            const next = node.next;
            alloc.destroy(node);
            orig = next;
        }
    }

    const expected: [6]i32 = .{ 1, 1, 2, 3, 4, 4 };
    var i: usize = 0;
    while (sol) |node| {
        try expect(node.val == expected[i]);
        i += 1;
        sol = node.next;
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const a = try Node.init(alloc, 0);

    var sol = try solution(alloc, a, null);
    var orig = sol;

    defer {
        while (orig) |node| {
            const next = node.next;
            alloc.destroy(node);
            orig = next;
        }
    }

    const expected: [1]i32 = .{0};
    var i: usize = 0;
    while (sol) |node| {
        try expect(node.val == expected[i]);
        i += 1;
        sol = node.next;
    }
}
