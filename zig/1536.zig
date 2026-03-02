const std = @import("std");

fn solution(alloc: std.mem.Allocator, grid: [][]const i32) !i32 {
    const n = grid.len;
    var result: i32 = 0;

    var max_right = try alloc.alloc(usize, n);
    defer alloc.free(max_right);

    for (grid, 0..) |row, i| {
        var last_one_idx: usize = 0;
        var j: usize = row.len;
        while (j > 0) {
            j -= 1;
            if (row[j] == 1) {
                last_one_idx = j;
                break;
            }
        }
        max_right[i] = last_one_idx;
    }

    for (0..n) |i| {
        var pos: ?usize = null;

        for (i..n) |j| {
            if (max_right[j] <= i) {
                pos = j;
                break;
            }
        }

        if (pos) |found_idx| {
            result += @intCast(found_idx - i);

            var k = found_idx;
            while (k > i) : (k -= 1) {
                std.mem.swap(usize, &max_right[k], &max_right[k - 1]);
            }
        } else {
            // Return -1 as an i32 to signal failure
            return -1;
        }
    }

    return result;
}
