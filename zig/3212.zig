const std = @import("std");

const Cell = struct {
    count: i32,
    valid: bool,
};

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, grid: [M][N]u8) !i32 {
    var result: i32 = 0;

    var cells = try allocator.alloc([]Cell, M);
    for (0..M) |i| {
        cells[i] = try allocator.alloc(Cell, N);
    }

    defer {
        for (0..M) |i| {
            allocator.free(cells[i]);
        }

        allocator.free(cells);
    }

    for (0..M) |i| {
        for (0..N) |j| {
            var count: i32 = -1;
            var valid = false;

            if (grid[i][j] == 'X') {
                count = 1;
                valid = true;
            } else if (grid[i][j] == '.') {
                count = 0;
            }

            if (i > 0) {
                count += cells[i - 1][j].count;

                if (cells[i - 1][j].valid) {
                    valid = true;
                }
            }

            if (j > 0) {
                count += cells[i][j - 1].count;

                if (cells[i][j - 1].valid) {
                    valid = true;
                }
            }

            if (i > 0 and j > 0) {
                count -= cells[i - 1][j - 1].count;
            }

            cells[i][j] = Cell{
                .count = count,
                .valid = valid,
            };
        }
    }

    for (cells) |row| {
        for (row) |cell| {
            if (cell.valid and cell.count == 0) {
                result += 1;
            }
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 3;

    const grid = [M][N]u8{
        .{ 'X', 'Y', '.' },
        .{ 'Y', '.', '.' },
    };

    const expected = 3;
    const actual = try solution(M, N, allocator, grid);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 2;

    const grid = [M][N]u8{
        .{ 'X', 'X' },
        .{ 'X', 'Y' },
    };

    const expected = 0;
    const actual = try solution(M, N, allocator, grid);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 2;

    const grid = [M][N]u8{
        .{ '.', '.' },
        .{ '.', '.' },
    };

    const expected = 0;
    const actual = try solution(M, N, allocator, grid);

    try expect(expected, actual);
}
