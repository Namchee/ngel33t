const std = @import("std");

fn solution(nums: []const i32) i32 {
    var result = nums[0];
    var start: usize = 0;
    var end: usize = nums.len - 1;

    while (start <= end) {
        if (nums[start] < nums[end]) {
            result = @min(result, nums[start]);
            break;
        }

        const mid = start + @divFloor(end - start, 2);
        result = @min(result, nums[mid]);

        if (nums[mid] >= nums[start]) {
            start = mid + 1;
        } else {
            end = mid - 1;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 3, 4, 5, 1, 2 };

    const expected = 1;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{ 4, 5, 6, 7, 0, 1, 2 };

    const expected = 0;
    const actual = solution(&nums);

    try expect(expected, actual);
}
