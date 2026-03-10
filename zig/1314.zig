const std = @import("std");

fn solution(allocator: std.mem.Allocator, grid: []const []i32, k: usize) ![][]i32 {
    var answer = try allocator.alloc([]i32, grid.len);
    for (0..grid.len) |i| {
        answer[i] = try allocator.alloc(i32, grid[i].len);
        @memset(answer[i], 0);
    }

    for (0..grid.len) |i| {
        for (0..grid[i].len) |j| {
            var val = grid[i][j];

            if (i > 0) {
                val += grid[i - 1][j];
            }

            if (j > 0) {
                val += grid[i][j - 1];
            }

            if (i > 0 and j > 0) {
                val -= grid[i - 1][j - 1];
            }

            grid[i][j] = val;
        }
    }

    for (0..grid.len) |i| {
        for (0..grid[i].len) |j| {
            var c = i + k;
            var d = j + k;

            if (c >= grid.len) {
                c = grid.len - 1;
            }

            if (d >= grid[i].len) {
                d = grid[i].len - 1;
            }

            var val = grid[c][d];

            if (i >= k + 1) {
                val -= grid[i - 1 - k][d];
            }

            if (j >= k + 1) {
                val -= grid[c][j - 1 - k];
            }

            if (i >= k + 1 and j >= k + 1) {
                val += grid[i - k - 1][j - k - 1];
            }

            answer[i][j] = val;
        }
    }

    return answer;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    var r1 = [_]i32{ 1, 2, 3 };
    var r2 = [_]i32{ 4, 5, 6 };
    var r3 = [_]i32{ 7, 8, 9 };

    const grid = [_][]i32{ &r1, &r2, &r3 };
    const k = 1;

    const sol = try solution(allocator, &grid, k);
    defer {
        for (0..grid.len) |i| {
            allocator.free(sol[i]);
        }

        allocator.free(sol);
    }

    var r4 = [_]i32{ 12, 21, 16 };
    var r5 = [_]i32{ 27, 45, 33 };
    var r6 = [_]i32{ 24, 39, 28 };

    const expected = [_][]i32{ &r4, &r5, &r6 };

    for (0..grid.len) |i| {
        for (0..grid[i].len) |j| {
            try expect(sol[i][j], expected[i][j]);
        }
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    var r1 = [_]i32{ 1, 2, 3 };
    var r2 = [_]i32{ 4, 5, 6 };
    var r3 = [_]i32{ 7, 8, 9 };

    const grid = [_][]i32{ &r1, &r2, &r3 };
    const k = 2;

    const sol = try solution(allocator, &grid, k);
    defer {
        for (0..grid.len) |i| {
            allocator.free(sol[i]);
        }

        allocator.free(sol);
    }

    var r4 = [_]i32{ 45, 45, 45 };
    var r5 = [_]i32{ 45, 45, 45 };
    var r6 = [_]i32{ 45, 45, 45 };

    const expected = [_][]i32{ &r4, &r5, &r6 };

    for (0..grid.len) |i| {
        for (0..grid[i].len) |j| {
            try expect(sol[i][j], expected[i][j]);
        }
    }
}
