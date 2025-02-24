const std = @import("std");

fn purge(comptime M: usize, comptime N: usize, grid: *[M][N]u8, i: isize, j: isize) void {
    if (i < 0 or i >= M or j < 0 or j >= N or grid[@as(usize, @intCast(i))][@as(usize, @intCast(j))] != '1') {
        return;
    }

    grid[@as(usize, @intCast(i))][@as(usize, @intCast(j))] = '0';
    purge(M, N, grid, i - 1, j);
    purge(M, N, grid, i + 1, j);
    purge(M, N, grid, i, j - 1);
    purge(M, N, grid, i, j + 1);
}

fn solution(comptime M: usize, comptime N: usize, grid: *[M][N]u8) usize {
    var islands: usize = 0;

    for (0..M) |i| {
        for (0..N) |j| {
            if (grid[i][j] == '1') {
                islands += 1;
                purge(M, N, grid, @intCast(i), @intCast(j));
            }
        }
    }

    return islands;
}

const expect = std.testing.expect;

test "test case #1" {
    var grid = [4][5]u8{
        .{ '1', '1', '1', '1', '0' },
        .{ '1', '1', '0', '1', '0' },
        .{ '1', '1', '0', '0', '0' },
        .{ '0', '0', '0', '0', '0' },
    };

    const sol = solution(4, 5, &grid);

    try expect(sol == 1);
}

test "test case #2" {
    var grid = [4][5]u8{
        .{ '1', '1', '0', '0', '0' },
        .{ '1', '1', '0', '0', '0' },
        .{ '0', '0', '1', '0', '0' },
        .{ '0', '0', '0', '1', '1' },
    };

    const sol = solution(4, 5, &grid);

    try expect(sol == 3);
}
