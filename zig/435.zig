const std = @import("std");

fn sortByEnd(_: void, lhs: []const i32, rhs: []const i32) bool {
    return lhs[1] < rhs[1];
}

fn solution(intervals: [][]const i32) usize {
    var result: usize = 0;

    std.mem.sort([]const i32, intervals, {}, sortByEnd);

    var right = intervals[0][1];

    for (1..intervals.len) |idx| {
        if (intervals[idx][0] < right) {
            result += 1;
        } else {
            right = intervals[idx][1];
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const a1 = [_]i32{ 1, 2 };
    const a2 = [_]i32{ 2, 3 };
    const a3 = [_]i32{ 3, 4 };
    const a4 = [_]i32{ 1, 3 };
    var intervals = [_][]const i32{ &a1, &a2, &a3, &a4 };
    const expected = 1;

    const sol = solution(&intervals);

    try expect(expected, sol);
}

test "test case #2" {
    const a1 = [_]i32{ 1, 2 };
    const a2 = [_]i32{ 1, 2 };
    const a3 = [_]i32{ 1, 2 };
    var intervals = [_][]const i32{ &a1, &a2, &a3 };
    const expected = 2;

    const sol = solution(&intervals);

    try expect(expected, sol);
}

test "test case #3" {
    const a1 = [_]i32{ 1, 2 };
    const a2 = [_]i32{ 2, 3 };
    var intervals = [_][]const i32{ &a1, &a2 };
    const expected = 0;

    const sol = solution(&intervals);

    try expect(expected, sol);
}
