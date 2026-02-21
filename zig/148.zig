const std = @import("std");

const ListNode = struct { val: i32, next: ?*ListNode = null };

fn merge(head: ?*ListNode) ?*ListNode {
    if (head == null or head.?.next == null) {
        return head;
    }

    var tortoise = head;
    var hare = head.?.next;

    while (hare != null and hare.?.next != null) {
        tortoise = tortoise.?.next;
        hare = hare.?.next.?.next;
    }

    const mid = tortoise.?.next;
    tortoise.?.next = null;

    var left = merge(head);
    var right = merge(mid);
    var dummy = ListNode{ .val = -1 };
    var walker = &dummy;

    while (left != null and right != null) {
        if (left.?.val <= right.?.val) {
            walker.next = left;
            left = left.?.next;
        } else {
            walker.next = right;
            right = right.?.next;
        }

        walker = walker.next.?;
    }

    walker.next = if (left != null) left else right;

    return dummy.next;
}

fn solution(node: ?*ListNode) ?*ListNode {
    return merge(node);
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const values = [_]i32{ -1, 5, 3, 4, 0 };
    var head: ?*ListNode = null;
    var current: ?*ListNode = null;

    for (values) |v| {
        const node = try alloc.create(ListNode);
        node.* = .{ .val = v, .next = null };
        if (head == null) {
            head = node;
            current = node;
        } else {
            current.?.next = node;
            current = node;
        }
    }

    const sorted_head = solution(head);

    const expected = [_]i32{ -1, 0, 3, 4, 5 };
    var it = sorted_head;
    for (expected) |exp| {
        const node = it.?;
        try std.testing.expectEqual(exp, node.val);
        it = node.next;
        alloc.destroy(node);
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    // Helper to build list from array
    const values = [_]i32{ -1, 5, 3, 4, 0 };
    var head: ?*ListNode = null;
    var current: ?*ListNode = null;

    // Allocate nodes
    for (values) |v| {
        const node = try alloc.create(ListNode);
        node.* = .{ .val = v, .next = null };
        if (head == null) {
            head = node;
            current = node;
        } else {
            current.?.next = node;
            current = node;
        }
    }

    const sorted_head = solution(head);

    const expected = [_]i32{ -1, 0, 3, 4, 5 };
    var it = sorted_head;
    for (expected) |exp| {
        const node = it.?;
        try std.testing.expectEqual(exp, node.val);
        it = node.next;
        alloc.destroy(node);
    }
}
