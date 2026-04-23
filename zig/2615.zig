const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) ![]usize {
    const n = nums.len;
    var result = try allocator.alloc(usize, n);
    var mp: std.AutoHashMap(i32, std.ArrayList(usize)) = .init(allocator);
    defer {
        var it = mp.iterator();

        while (it.next()) |entry| {
            entry.value_ptr.deinit(allocator);
        }

        mp.deinit();
    }

    for (nums, 0..) |num, i| {
        var ptr = try mp.getOrPut(num);
        if (!ptr.found_existing) {
            ptr.value_ptr.* = .empty;
        }

        try ptr.value_ptr.append(allocator, i);
    }

    var it = mp.iterator();
    while (it.next()) |entry| {
        var prefix: usize = 0;
        var lsum: usize = 0;

        for (entry.value_ptr.items) |num| {
            prefix += num;
        }

        for (0..entry.value_ptr.items.len) |i| {
            const rsum = prefix - lsum - entry.value_ptr.items[i];

            const left = entry.value_ptr.items[i] * i - lsum;
            const right = rsum - entry.value_ptr.items[i] * (entry.value_ptr.items.len - i - 1);

            result[entry.value_ptr.items[i]] = left + right;
            lsum += entry.value_ptr.items[i];
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 3, 1, 1, 2 };
    const expected = [_]usize{ 5, 0, 3, 4, 0 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(expected[i] == actual[i]);
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 0, 5, 3 };
    const expected = [_]usize{ 0, 0, 0 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(expected[i] == actual[i]);
    }
}
