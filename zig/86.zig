const std = @import("std");

const ListNode = struct {
    val: i32,
    next: ?*ListNode,
};

fn solution(node: ?*ListNode, x: i32) ?*ListNode {
    const beforeDummy = &ListNode{};
    const afterDummy = &ListNode{};

    var before = beforeDummy;
    var after = afterDummy;

    var runner = node;

    while (runner) |n| {
        if (n.val < x) {
            before.next = n;
            before = before.next;
        } else {
            after.next = n;
            after = after.next;
        }

        runner = runner.next;
    }

    after.next = null;
    before.next = afterDummy.next;

    return beforeDummy.next;
}
