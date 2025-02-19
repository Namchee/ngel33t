const std = @import("std");

fn create_node(comptime T: type) type {
    const Node = struct {
        const Self = @This();

        val: T,
        next: ?*Self,

        pub fn init(alloc: std.mem.Allocator, val: T) !*Self {
            var new_node = try alloc.create(Self);
            new_node.val = val;
            new_node.next = null;

            return new_node;
        }
    };

    return Node;
}

const expect = std.testing.expect;

test "test case #1" {
    const Node = create_node(i32);
    const alloc = std.testing.allocator;

    const a = try Node.init(alloc, 9);
    defer alloc.destroy(a);
}

test "test case #2" {}

test "test case #3" {}
