const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32, k: usize) !i32 {
    const n = nums.len;

    var result = try allocator.alloc(i32, n);
    result[0] = nums[0];

    var deque: std.ArrayList(usize) = .empty;
    defer {
        allocator.free(result);
        deque.deinit(allocator);
    }

    try deque.append(allocator, 0);

    for (1..n) |i| {
        if (deque.items.len > 0 and deque.items[0] + k < i) {
            _ = deque.orderedRemove(0);
        }

        result[i] = nums[i] + result[deque.items[0]];
        while (deque.items.len > 0 and result[deque.items[deque.items.len - 1]] <= result[i]) {
            _ = deque.pop();
        }

        try deque.append(allocator, i);
    }

    return result[n - 1];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, -1, -2, 4, -7, 3 };
    const k = 2;

    const expected = 7;
    const actual = try solution(allocator, &nums, k);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 10, -5, -2, 4, 0, 3 };
    const k = 3;

    const expected = 17;
    const actual = try solution(allocator, &nums, k);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, -5, -20, 4, -1, 3, -6, -3 };
    const k = 2;

    const expected = 0;
    const actual = try solution(allocator, &nums, k);

    try expect(expected, actual);
}
