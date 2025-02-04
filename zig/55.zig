const std = @import("std");

fn solution(nums1: []i32) !bool {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var arr = std.ArrayList(bool).init(allocator);
    defer arr.deinit();

    try arr.resize(nums1.len);
    arr.items[0] = true;

    for (0..nums1.len) |idx| {
        if (!arr.items[idx]) {
            continue;
        }

        for (1..@intCast(nums1[idx] + 1)) |inc| {
            if (idx + inc >= nums1.len) {
                break;
            }

            arr.items[idx + inc] = true;
        }
    }

    return arr.getLast();
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 2, 3, 1, 1, 4 };

    const possible = try solution(&nums);

    try expect(possible);
}

test "test case #2" {
    var nums = [_]i32{ 3, 2, 1, 0, 4 };

    const possible = try solution(&nums);

    try expect(!possible);
}
