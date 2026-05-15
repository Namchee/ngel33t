const std = @import("std");

fn solution(fruits: []const i32, baskets: []i32) i32 {
    var result: i32 = 0;

    for (0..fruits.len) |i| {
        var placed = false;

        for (0..baskets.len) |j| {
            if (baskets[j] > -1 and fruits[i] <= baskets[j]) {
                baskets[j] = -1;
                placed = true;
                break;
            }
        }

        if (!placed) {
            result += 1;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const fruits = [_]i32{ 4, 2, 5 };
    var baskets = [_]i32{ 3, 5, 4 };

    const expected = 1;
    const actual = solution(&fruits, &baskets);

    try expect(expected, actual);
}

test "test case #2" {
    const fruits = [_]i32{ 3, 6, 1 };
    var baskets = [_]i32{ 6, 4, 7 };

    const expected = 0;
    const actual = solution(&fruits, &baskets);

    try expect(expected, actual);
}
