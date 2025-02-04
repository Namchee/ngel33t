const std = @import("std");

fn solution(nums1: []i32) !u32 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var arr = std.ArrayList(u32).init(allocator);
    defer arr.deinit();

    try arr.resize(nums1.len);
    for (0..nums1.len) |idx| {
        arr.items[idx] = std.math.maxInt(u32);
    }

    arr.items[0] = 0;

    for (0..nums1.len) |idx| {
        if (arr.items[idx] == std.math.maxInt(u32)) {
            continue;
        }

        for (1..@intCast(nums1[idx] + 1)) |inc| {
            if (idx + inc >= nums1.len) {
                break;
            }

            arr.items[idx + inc] = @min(arr.items[idx + inc], arr.items[idx] + 1);
        }
    }

    return arr.getLast();
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 2, 3, 1, 1, 4 };

    const steps = try solution(&nums);

    try expect(steps == 2);
}

test "test case #2" {
    var nums = [_]i32{ 2, 3, 0, 1, 4 };

    const possible = try solution(&nums);

    try expect(possible == 2);
}
