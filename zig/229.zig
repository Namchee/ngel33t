const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) !std.ArrayList(i32) {
    var candidate1: i32 = 0;
    var candidate2: i32 = 0;
    var count1: i32 = 0;
    var count2: i32 = 0;

    for (nums) |el| {
        if (el == candidate1) {
            count1 += 1;
        } else if (el == candidate2) {
            count2 += 1;
        } else if (count1 == 0) {
            candidate1 = el;
            count1 = 1;
        } else if (count2 == 0) {
            candidate2 = el;
            count2 = 1; // Fixed incorrect assignment
        } else {
            count1 -= 1;
            count2 -= 1;
        }
    }

    count1 = 0;
    count2 = 0;

    for (nums) |el| {
        if (el == candidate1) {
            count1 += 1;
        } else if (el == candidate2) {
            count2 += 1;
        }
    }

    var result = std.ArrayList(i32).init(allocator);

    if (count1 > nums.len / 3) {
        try result.append(candidate1);
    }

    if (count2 > nums.len / 3) {
        try result.append(candidate2);
    }

    return result;
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;
    var nums = [_]i32{ 3, 2, 3 };

    var majority = try solution(allocator, &nums);
    defer majority.deinit(); // Ensure memory is freed

    var expected = [_]i32{3};
    try expect(isEqual(i32, majority.items, &expected));
}

test "test case #2" {
    const allocator = std.testing.allocator;
    var nums = [_]i32{1};

    var majority = try solution(allocator, &nums);
    defer majority.deinit();

    var expected = [_]i32{1};
    try expect(isEqual(i32, majority.items, &expected));
}

test "test case #3" {
    const allocator = std.testing.allocator;
    var nums = [_]i32{ 1, 2 };

    var majority = try solution(allocator, &nums);
    defer majority.deinit();

    var expected = [_]i32{ 1, 2 };
    try expect(isEqual(i32, majority.items, &expected));
}
