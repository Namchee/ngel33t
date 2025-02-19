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

fn free_memory(alloc: std.mem.Allocator, head: ?*Node) void {
    var curr = head;
    while (curr) |node| {
        const next = node.next;
        alloc.destroy(node);
        curr = next;
    }
}

fn solution(alloc: std.mem.Allocator, a: *Node, b: *Node) !?*Node {
    var head_a: ?*Node = a;
    var head_b: ?*Node = b;

    var head: ?*Node = null;
    var sum: ?*Node = null;

    var carry: i32 = 0;

    while (head_a != null or head_b != null) {
        var curr: i32 = 0;
        if (head_a) |node| {
            curr += node.val;
            head_a = node.next;
        }

        if (head_b) |node| {
            curr += node.val;
            head_b = node.next;
        }

        carry = @divFloor(curr, 10);
        const new_node = try Node.init(alloc, @rem(curr, 10));

        if (sum == null) {
            sum = new_node;
            head = new_node;
        } else {
            sum.?.next = new_node;
            sum = new_node;
        }
    }

    if (carry > 0) {
        const new_node = try Node.init(alloc, carry);
        sum.?.next = new_node;
    }

    return head;
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

    var sol = try solution(alloc, a, b);

    try expect(sol.?.val == 7);
    sol = sol.?.next;
    try expect(sol.?.val == 0);
    sol = sol.?.next;
    try expect(sol.?.val == 8);
    sol = sol.?.next;
    try expect(sol == null);

    free_memory(alloc, a);
    free_memory(alloc, b);
    free_memory(alloc, sol);
}

test "test case #2" {}

test "test case #3" {}
