const std = @import("std");

fn detectCycle(comptime M: usize, comptime N: usize, x: usize, y: usize, px: i32, py: i32, t: u8, grid: [M][N]u8, visited: *[M][N]bool) bool {
    visited[x][y] = true;

    const dx = [_]i32{ 0, 0, -1, 1 };
    const dy = [_]i32{ -1, 1, 0, 0 };

    for (0..4) |i| {
        const nx_i: i32 = @intCast(x);
        const ny_i: i32 = @intCast(y);

        const next_x = nx_i + dx[i];
        const next_y = ny_i + dy[i];

        if (next_x >= 0 and next_x < M and next_y >= 0 and next_y < N) {
            const nx: usize = @intCast(next_x);
            const ny: usize = @intCast(next_y);

            if (grid[nx][ny] == t) {
                if (visited[nx][ny]) {
                    if (nx != @as(usize, @intCast(px)) or ny != @as(usize, @intCast(py))) {
                        return true;
                    }

                    continue;
                }

                if (detectCycle(M, N, nx, ny, @intCast(x), @intCast(y), t, grid, visited)) {
                    return true;
                }
            }
        }
    }

    return false;
}

fn solution(comptime M: usize, comptime N: usize, grid: [M][N]u8) bool {
    var visited: [M][N]bool = .{.{false} ** N} ** M;

    for (0..grid.len) |i| {
        for (0..grid[i].len) |j| {
            if (!visited[i][j]) {
                if (detectCycle(M, N, i, j, -1, -1, grid[i][j], grid, &visited)) {
                    return true;
                }
            }
        }
    }

    return false;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 4;
    const N = 4;

    const grid = [M][N]u8{
        .{ 'a', 'a', 'a', 'a' },
        .{ 'a', 'b', 'b', 'a' },
        .{ 'a', 'b', 'b', 'a' },
        .{ 'a', 'a', 'a', 'a' },
    };

    const expected = true;
    const actual = solution(M, N, grid);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 4;
    const N = 4;

    const grid = [M][N]u8{
        .{ 'c', 'c', 'c', 'a' },
        .{ 'c', 'd', 'c', 'c' },
        .{ 'c', 'c', 'e', 'c' },
        .{ 'f', 'c', 'c', 'c' },
    };

    const expected = true;
    const actual = solution(M, N, grid);

    try expect(expected, actual);
}

test "test case #3" {
    const M = 3;
    const N = 3;

    const grid = [M][N]u8{
        .{ 'a', 'b', 'b' },
        .{ 'b', 'z', 'b' },
        .{ 'b', 'b', 'a' },
    };

    const expected = false;
    const actual = solution(M, N, grid);

    try expect(expected, actual);
}
