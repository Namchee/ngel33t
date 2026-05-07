const std = @import("std");

fn solution(comptime N: usize, nums: [N]i32) [N]i32 {
    var result: [N]i32 = [_]i32{0} ** N;
    var prefix: [N]i32 = [_]i32{0} ** N;
    var suffix: [N]i32 = [_]i32{0} ** N;

    prefix[0] = nums[0];
    for (1..N) |i| {
        prefix[i] = @max(prefix[i - 1], nums[i]);
    }

    suffix[N - 1] = nums[N - 1];
    var idx: usize = N - 1;
    while (idx > 0) : (idx -= 1) {
        suffix[idx - 1] = @min(suffix[idx], nums[idx - 1]);
    }

    result[N - 1] = prefix[N - 1];
    idx = N - 1;

    while (idx > 0) : (idx -= 1) {
        if (prefix[idx - 1] > suffix[idx]) {
            result[idx - 1] = result[idx];
        } else {
            result[idx - 1] = prefix[idx - 1];
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const N = 3;

    const nums = [N]i32{ 2, 1, 3 };
    const expected = [N]i32{ 2, 2, 3 };
    const actual = solution(N, nums);

    try expect(std.mem.eql(i32, &expected, &actual));
}

test "test case #2" {
    const N = 3;

    const nums = [N]i32{ 2, 3, 1 };
    const expected = [N]i32{ 3, 3, 3 };
    const actual = solution(N, nums);

    try expect(std.mem.eql(i32, &expected, &actual));
}
