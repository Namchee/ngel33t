const std = @import("std");

fn solution(nums: []const i32) u32 {
    var result: u32 = 0;

    var i: usize = 2;

    while (i < nums.len) : (i += 1) {
        const diff = nums[i] - nums[i - 1];

        if (nums[i - 1] - nums[i - 2] == diff) {
            var ct: u32 = 1;
            var last = nums[i];

            var j = i + 1;

            while (j < nums.len) : (j += 1) {
                if (nums[j] - last != diff) {
                    break;
                }

                ct += 1;
                last = nums[j];
            }

            i = j - 1;
            result += (ct * (ct + 1)) / 2;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const input = [_]i32{ 1, 2, 3, 4 };
    const expected = 3;

    try expect(solution(&input), expected);
}

test "test case #2" {
    const input = [_]i32{1};
    const expected = 0;

    try expect(solution(&input), expected);
}
