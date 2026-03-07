const std = @import("std");

fn solution(gas: []i32, cost: []i32) i32 {
    var rem: i32 = 0;
    var tank: i32 = 0;

    var start: i32 = 0;

    for (0..gas.len) |idx| {
        rem += gas[idx] - cost[idx];
        tank += gas[idx] - cost[idx];

        if (tank < 0) {
            tank = 0;
            start = @as(i32, @intCast(idx)) + 1;
        }
    }

    if (rem < 0) {
        return -1;
    }

    return start;
}

const expect = std.testing.expect;

test "test case #1" {
    var gas = [_]i32{ 1, 2, 3, 4, 5 };
    var cost = [_]i32{ 3, 4, 5, 1, 2 };

    const idx = solution(&gas, &cost);

    try expect(idx == 3);
}

test "test case #2" {
    var gas = [_]i32{ 2, 3, 4 };
    var cost = [_]i32{ 3, 4, 4 };

    const idx = solution(&gas, &cost);

    try expect(idx == -1);
}
