const std = @import("std");

fn solution(arr: []const i32) bool {
    var sum: i32 = 0;
    for (arr) |num| {
        sum += num;
    }

    if (@mod(sum, 3) != 0) {
        return false;
    }

    const target = @divExact(sum, 3);
    var acc: i32 = 0;
    var count: usize = 0;

    for (0..arr.len - 1) |i| {
        acc += arr[i];

        if (acc == target) {
            count += 1;
            acc = 0;

            if (count == 2) {
                return true;
            }
        }
    }

    return false;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const arr = [_]i32{ 0, 2, 1, -6, 6, -7, 9, 1, 2, 0, 1 };

    const expected = true;
    const actual = solution(&arr);

    try expect(expected, actual);
}

test "test case #2" {
    const arr = [_]i32{ 0, 2, 1, -6, 6, 7, 9, -1, 2, 0, 1 };

    const expected = false;
    const actual = solution(&arr);

    try expect(expected, actual);
}

test "test case #3" {
    const arr = [_]i32{ 3, 3, 6, 5, -2, 2, 5, 1, -9, 4 };

    const expected = true;
    const actual = solution(&arr);

    try expect(expected, actual);
}
