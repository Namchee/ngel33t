const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []i32) ![]i32 {
    var result = try allocator.alloc(i32, nums.len);

    std.mem.sort(i32, nums, {}, std.sort.asc(i32));

    var i: usize = 0;
    var j: usize = 0;

    while (i < nums.len) {
        const a = nums[i];
        i += 1;
        const b = nums[i];
        i += 1;

        result[j] = b;
        j += 1;
        result[j] = a;
        j += 1;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;
    var nums = [_]i32{ 5, 4, 2, 3 };

    const expected = [_]i32{ 3, 2, 5, 4 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;
    var nums = [_]i32{ 2, 5 };

    const expected = [_]i32{ 5, 2 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
