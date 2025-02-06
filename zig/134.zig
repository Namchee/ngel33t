const std = @import("std");

fn solution(gas: []i32, cost: []i32) i32 {
    for (0..gas.len) |start| {
        var idx = start;
        var tank: i32 = 0;

        while (true) {
            tank += gas[idx];
            if (tank < cost[idx]) {
                break;
            }

            tank -= cost[idx];

            idx = (idx + 1) % gas.len;
            if (idx == start) {
                return @intCast(start);
            }
        }
    }

    return -1;
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
