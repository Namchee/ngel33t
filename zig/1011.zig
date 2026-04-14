const std = @import("std");

fn solution(weights: []const i32, days: i32) i32 {
    var best: i32 = 0;

    var left: i32 = 0;
    var right: i32 = 0;

    for (weights) |w| {
        right += w;
    }

    if (days == 1) {
        return right;
    }

    while (left <= right) {
        const mid = left + @divFloor(right - left, 2);

        var over = false;
        var req: i32 = 0;
        var curr: i32 = 0;

        for (weights) |w| {
            if (w > mid) {
                over = true;
                break;
            }

            if (curr + w > mid) {
                req += 1;
                curr = w;
                continue;
            }

            curr += w;
        }

        if (over or req >= days) {
            left = mid + 1;
        } else {
            best = mid;
            right = mid - 1;
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const weights = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    const days = 5;

    const expected = 15;
    const actual = solution(&weights, days);

    try expect(expected, actual);
}

test "test case #2" {
    const weights = [_]i32{ 3, 2, 2, 4, 1, 4 };
    const days = 3;

    const expected = 6;
    const actual = solution(&weights, days);

    try expect(expected, actual);
}

test "test case #3" {
    const weights = [_]i32{ 1, 2, 3, 1, 1 };
    const days = 4;

    const expected = 3;
    const actual = solution(&weights, days);

    try expect(expected, actual);
}
