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

fn solution(alloc: std.mem.Allocator, head: ?*Node, left: usize, right: usize) !?*Node {
    if (head == null or left == right) {
        return head;
    }

    var dummy = try Node.init(alloc, -1);
    dummy.next = head;
    defer alloc.destroy(dummy);

    var prev: ?*Node = dummy;

    for (0..left - 1) |_| {
        prev = prev.?.next;
    }

    var curr: ?*Node = prev.?.next;

    for (0..right - left) |_| {
        var temp: ?*Node = curr.?.next;
        curr.?.next = temp.?.next;
        temp.?.next = prev.?.next;
        prev.?.next = temp;
    }

    return dummy.next;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const content = [_]i32{ 1, 2, 3, 4, 5 };
    const sentinel: ?*Node = try Node.init(alloc, -1);
    defer {
        if (sentinel) |node| {
            alloc.destroy(node);
        }
    }

    var runner: ?*Node = sentinel;
    for (content) |num| {
        const node = try Node.init(alloc, num);
        runner.?.next = node;
        defer alloc.destroy(node);
        runner = runner.?.next;
    }

    const sol = try solution(alloc, sentinel.?.next, 2, 4);
    runner = sol;

    const expected = [_]i32{ 1, 4, 3, 2, 5 };
    runner = sol;

    for (expected) |num| {
        try expect(num == runner.?.val);
        runner = runner.?.next;
    }
}
