const std = @import("std");

const Node = struct {
    val: i32,
    next: ?*Node,

    pub fn init(val: i32) Node {
        return Node{
            .val = val,
            .next = null,
        };
    }
};

fn solution(head: ?*Node) bool {
    var tortoise = head;
    var hare = head;

    while (tortoise != null and hare != null and hare.?.next != null) {
        tortoise = tortoise.?.next;
        hare = hare.?.next.?.next;

        if (tortoise == hare) {
            return true;
        }
    }

    return false;
}

const expect = std.testing.expect;

test "test case #1" {
    var a = Node.init(3);
    var b = Node.init(2);
    var c = Node.init(0);
    var d = Node.init(-4);

    a.next = &b;
    b.next = &c;
    c.next = &d;
    d.next = &b;

    const sol = solution(&a);

    try expect(sol);
}

test "test case #2" {
    var a = Node.init(1);
    var b = Node.init(2);

    a.next = &b;
    b.next = &a;

    const sol = solution(&a);

    try expect(sol);
}

test "test case #3" {
    var a = Node.init(1);

    const sol = solution(&a);

    try expect(!sol);
}
