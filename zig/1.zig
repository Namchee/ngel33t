const std = @import("std");

const expect = std.testing.expect;

fn solution(nums: *std.ArrayList(i32), target: i32) !struct { i32, i32 } {
    var mp = std.AutoHashMap(i32, i32).init(std.heap.page_allocator);
    defer mp.deinit();

    for (nums.items, 0..) |el, idx| {
        const pair = target - el;

        if (mp.get(pair)) |loc| {
            return .{ loc, @intCast(idx) };
        } else {
            try mp.put(el, @intCast(idx));
        }
    }

    return .{ -1, -1 };
}

test "test case #1" {
    var nums = std.ArrayList(i32).init(std.testing.allocator);
    defer nums.deinit();

    try nums.append(2);
    try nums.append(7);
    try nums.append(11);
    try nums.append(15);

    const target = 9;

    const result = try solution(&nums, target);

    try expect(result[0] == 0);
    try expect(result[1] == 1);
}

test "test case #2" {
    var nums = std.ArrayList(i32).init(std.testing.allocator);
    defer nums.deinit();

    try nums.append(3);
    try nums.append(2);
    try nums.append(4);

    const target = 6;

    const result = try solution(&nums, target);

    try expect(result[0] == 1);
    try expect(result[1] == 2);
}

test "test case #3" {
    var nums = std.ArrayList(i32).init(std.testing.allocator);
    defer nums.deinit();

    try nums.append(3);
    try nums.append(3);

    const target = 6;

    const result = try solution(&nums, target);

    try expect(result[0] == 0);
    try expect(result[1] == 1);
}
