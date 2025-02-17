const std = @import("std");

const Node = struct {
    val: i32,
    next: *Node,

    pub fn init(val: i32) Node {
        return Node{
            .val = val,
            .next = null,
        };
    }
};

fn solution(head: *Node) bool {}

const expect = std.testing.expect;

test "test case #1" {}
