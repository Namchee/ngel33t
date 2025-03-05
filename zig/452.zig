const std = @import("std");

const Interval = [2]usize;

fn comparator(_: void, a: Interval, b: Interval) bool {
    if (a[0] < b[0]) {
        return true;
    }

    return b[1] < b[1];
}

fn solution(intervals: []Interval) usize {
    if (intervals.len <= 1) {
        return intervals.len;
    }

    var count: usize = 1;

    std.mem.sort(Interval, intervals, {}, comparator);

    var start: usize = intervals[0][0];
    var end: usize = intervals[0][1];

    for (1..intervals.len) |idx| {
        if (intervals[idx][0] >= start and intervals[idx][0] <= end) {
            start = @max(start, intervals[idx][0]);
            end = @min(end, intervals[idx][1]);
            continue;
        }

        count += 1;
        start = intervals[idx][0];
        end = intervals[idx][1];
    }

    return count;
}

const expect = std.testing.expect;

test "test case #1" {
    var intervals = [_]Interval{
        .{ 10, 16 },
        .{ 2, 8 },
        .{ 1, 6 },
        .{ 7, 12 },
    };

    const sol = solution(&intervals);

    try expect(sol == 2);
}

test "test case #2" {
    var intervals = [_]Interval{
        .{ 1, 2 },
        .{ 3, 4 },
        .{ 5, 6 },
        .{ 7, 8 },
    };

    const sol = solution(&intervals);

    try expect(sol == 4);
}

test "test case #3" {
    var intervals = [_]Interval{
        .{ 1, 2 },
        .{ 2, 3 },
        .{ 3, 4 },
        .{ 4, 5 },
    };

    const sol = solution(&intervals);

    try expect(sol == 2);
}
