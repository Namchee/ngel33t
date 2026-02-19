const std = @import("std");
const ArrayList = std.ArrayList;
const Pair = struct { i32, i32 };

fn solution(nums: []i32, alloc: std.mem.Allocator) !ArrayList(Pair) {
    std.mem.sort(i32, nums, {}, std.sort.asc(i32));

    var result: ArrayList(Pair) = .empty;
    var best: i32 = nums[nums.len - 1] - nums[0];

    for (1..nums.len) |idx| {
        const diff = nums[idx] - nums[idx - 1];
        if (diff == best) {
            try result.append(alloc, .{ nums[idx - 1], nums[idx] });
        } else if (diff < best) {
            result.clearRetainingCapacity();
            try result.append(alloc, .{ nums[idx - 1], nums[idx] });
            best = diff;
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 4, 2, 1, 3 };
    const expected: []const Pair = &.{ .{ 1, 2 }, .{ 2, 3 }, .{ 3, 4 } };

    var sol = try solution(&input, alloc);
    defer sol.deinit(alloc);

    try expect(sol.items.len == expected.len);
    for (0..sol.items.len) |idx| {
        try expect(sol.items[idx][0] == expected[idx][0]);
        try expect(sol.items[idx][1] == expected[idx][1]);
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 1, 3, 6, 10, 15 };
    const expected: []const Pair = &.{.{ 1, 3 }};

    var sol = try solution(&input, alloc);
    defer sol.deinit(alloc);

    try expect(sol.items.len == expected.len);
    for (0..sol.items.len) |idx| {
        try expect(sol.items[idx][0] == expected[idx][0]);
        try expect(sol.items[idx][1] == expected[idx][1]);
    }
}

test "test case #3" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 3, 8, -10, 23, 19, -4, -14, 27 };
    const expected: []const Pair = &.{ .{ -14, -10 }, .{ 19, 23 }, .{ 23, 27 } };

    var sol = try solution(&input, alloc);
    defer sol.deinit(alloc);

    try expect(sol.items.len == expected.len);
    for (0..sol.items.len) |idx| {
        try expect(sol.items[idx][0] == expected[idx][0]);
        try expect(sol.items[idx][1] == expected[idx][1]);
    }
}
