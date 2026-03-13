const std = @import("std");

fn simulate(h: i32, t: []const i32, lim: i64) bool {
    var total: i64 = 0;

    for (t) |time| {
        const limit = 2 * @divFloor(lim, time);
        const k = (std.math.sqrt(@as(u64, @intCast(1 + 4 * limit))) - 1) / 2;
        total += k;

        if (total >= h) {
            return true;
        }
    }

    return total >= h;
}

fn solution(h: i32, t: []const i32) i64 {
    var left: i64 = 0;
    var right: i64 = @divFloor(t[0] * h * (h + 1), 2);

    var ans = right;

    while (left <= right) {
        const mid = left + @divFloor(right - left, 2);

        if (simulate(h, t, mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const h = 4;
    const t = [_]i32{ 2, 1, 1 };

    const expected = 3;
    const actual = solution(h, &t);

    try expect(expected, actual);
}

test "test case #2" {
    const h = 10;
    const t = [_]i32{ 3, 2, 2, 4 };

    const expected = 12;
    const actual = solution(h, &t);

    try expect(expected, actual);
}
