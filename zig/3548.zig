const std = @import("std");
const Allocator = std.mem.Allocator;

fn rotateGrid(allocator: Allocator, grid: [][]i32) ![][]i32 {
    const m = grid.len;
    const n = grid[0].len;

    var container = try allocator.alloc([]i32, n);
    for (container, 0..) |*row, j| {
        row.* = try allocator.alloc(i32, m);
        for (grid, 0..) |old_row, i| {
            container[j][m - 1 - i] = old_row[j];
        }
    }

    return container;
}

fn freeGrid(allocator: Allocator, grid: [][]i32) void {
    for (grid) |row| {
        allocator.free(row);
    }

    allocator.free(grid);
}

pub fn canPartitionGrid(allocator: Allocator, initial_grid: [][]i32) !bool {
    var m = initial_grid.len;
    var n = initial_grid[0].len;
    var total: i64 = 0;

    for (initial_grid) |row| {
        for (row) |val| total += val;
    }

    var current_grid = initial_grid;
    var rotations: u2 = 0;

    while (rotations < 4) : (rotations += 1) {
        m = current_grid.len;
        n = current_grid[0].len;

        var exist = std.AutoHashMap(i64, bool).init(allocator);
        defer exist.deinit();
        try exist.put(0, true);

        var current_sum: i64 = 0;

        if (m < 2) {
            const next = try rotateGrid(allocator, current_grid);
            if (rotations > 0) {
                freeGrid(allocator, current_grid);
            }

            current_grid = next;
            continue;
        }

        if (n == 1) {
            var i: usize = 0;
            while (i < m - 1) : (i += 1) {
                current_sum += current_grid[i][0];
                const tag = current_sum * 2 - total;

                if (tag == 0 or tag == @as(i64, current_grid[0][0]) or tag == @as(i64, current_grid[i][0])) {
                    if (rotations > 0) {
                        freeGrid(allocator, current_grid);
                    }

                    return true;
                }
            }
        } else {
            // General case: 2D block
            var i: usize = 0;
            while (i < m - 1) : (i += 1) {
                for (current_grid[i]) |val| {
                    try exist.put(val, true);
                    current_sum += val;
                }

                const tag = current_sum * 2 - total;

                if (i == 0) {
                    if (tag == 0 or tag == @as(i64, current_grid[0][0]) or tag == @as(i64, current_grid[0][n - 1])) {
                        if (rotations > 0) {
                            freeGrid(allocator, current_grid);
                        }

                        return true;
                    }
                } else {
                    if (exist.contains(tag)) {
                        if (rotations > 0) {
                            freeGrid(allocator, current_grid);
                        }

                        return true;
                    }
                }
            }
        }

        const next = try rotateGrid(allocator, current_grid);
        if (rotations > 0) {
            freeGrid(allocator, current_grid);
        }

        current_grid = next;
    }

    if (current_grid.ptr != initial_grid.ptr) {
        freeGrid(allocator, current_grid);
    }

    return false;
}
