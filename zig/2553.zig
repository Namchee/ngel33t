const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) ![]i32 {
    var temp: std.ArrayList(i32) = .empty;
    var result: std.ArrayList(i32) = .empty;

    defer {
        temp.deinit(allocator);
        result.deinit(allocator);
    }

    var idx = nums.len;

    while (idx > 0) : (idx -= 1) {
        var t = nums[idx - 1];
        while (t > 0) {
            try temp.append(allocator, @mod(t, 10));
            t = @divFloor(t, 10);
        }
    }

    idx = temp.items.len;

    while (idx > 0) : (idx -= 1) {
        try result.append(allocator, temp.items[idx - 1]);
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 13, 25, 83, 77 };
    const expected = [_]i32{ 1, 3, 2, 5, 8, 3, 7, 7 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 7, 1, 3, 9 };
    const expected = [_]i32{ 7, 1, 3, 9 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
