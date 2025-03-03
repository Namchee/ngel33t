const std = @import("std");

const steps = [_]usize{ 1, 2 };

fn solution(comptime num: i32) i32 {
    var table: [num + 1]i32 = [_]i32{0} ** (num + 1);
    table[0] = 1;

    for (1..num + 1) |idx| {
        for (steps) |step| {
            if (idx >= step) {
                table[idx] += table[idx - step];
            }
        }
    }

    return table[@as(usize, @intCast(num))];
}

const expect = std.testing.expect;

test "test case #1" {
    const num = 2;

    const sol = solution(num);

    try expect(sol == 2);
}

test "test case #2" {
    const num = 3;

    const sol = solution(num);

    try expect(sol == 3);
}
