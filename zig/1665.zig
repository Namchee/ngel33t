const std = @import("std");

fn comparator(_: void, a: [2]i32, b: [2]i32) bool {
    const adiff = a[1] - a[0];
    const bdiff = b[1] - b[0];

    return adiff > bdiff;
}

fn solution(tasks: [][2]i32) i32 {
    std.mem.sort([2]i32, tasks, {}, comparator);

    var energy: i32 = 0;
    var result: i32 = 0;

    for (tasks) |t| {
        if (energy < t[1]) {
            result += (t[1] - energy);
            energy = t[1];
        }

        energy -= t[0];
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    var tasks = [_][2]i32{
        .{ 1, 2 },
        .{ 2, 4 },
        .{ 4, 8 },
    };

    const expected = 8;
    const actual = solution(&tasks);

    try expect(expected, actual);
}

test "test case #2" {
    var tasks = [_][2]i32{
        .{ 1, 3 },
        .{ 2, 4 },
        .{ 10, 11 },
        .{ 10, 12 },
        .{ 8, 9 },
    };

    const expected = 32;
    const actual = solution(&tasks);

    try expect(expected, actual);
}

test "test case #3" {
    var tasks = [_][2]i32{ .{ 1, 7 }, .{ 2, 8 }, .{ 3, 9 }, .{ 4, 10 }, .{ 5, 11 }, .{ 6, 12 } };

    const expected = 27;
    const actual = solution(&tasks);

    try expect(expected, actual);
}
