const std = @import("std");

const Node = struct {
    value: i32,
    next: ?*Node,
};

fn isSorted(node: ?*Node) bool {
    var walker = node orelse return true;

    while (walker.next) |next_node| {
        if (next_node.value < walker.value) {
            return false;
        }

        walker = next_node;
    }

    return true;
}

fn solution(nums: []i32, base: std.mem.Allocator) !u32 {
    var arena = std.heap.ArenaAllocator.init(base);

    defer arena.deinit();
    const alloc = arena.allocator();

    var root: Node = .{ .value = 123, .next = null };
    var walker: *Node = &root;

    for (nums) |num| {
        const new_node = try alloc.create(Node);
        new_node.* = .{ .value = num, .next = null };

        walker.next = new_node;
        walker = new_node;
    }

    const head = root.next;
    var op: u32 = 0;

    while (!isSorted(head)) {
        var best = head.?;
        var curr = head;
        var mini: i32 = std.math.maxInt(i32);

        while (curr) |node| {
            if (node.next) |n| {
                const sum = node.value + n.value;
                if (sum < mini) {
                    mini = sum;
                    best = node;
                }
                curr = node.next;
            } else break;
        }

        if (best.next) |b| {
            best.value += b.value;
            best.next = b.next;

            op += 1;
        } else break;
    }

    return op;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 5, 2, 3, 1 };
    const expected = 2;

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 1, 2, 2 };
    const expected = 0;

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}
