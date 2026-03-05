const std = @import("std");

fn solution(allocator: std.mem.Allocator, matrix: []const []const u8) !u32 {
    var table = try allocator.alloc([]u8, matrix.len + 1);
    for (0..matrix.len + 1) |idx| {
        table[idx] = try allocator.alloc(u8, matrix[0].len + 1);
        @memset(table[idx], 0);
    }

    defer {
        for (0..matrix.len + 1) |idx| {
            allocator.free(table[idx]);
        }

        allocator.free(table);
    }

    var result: u32 = 0;

    for (1..matrix.len + 1) |i| {
        for (1..matrix[0].len + 1) |j| {
            if (matrix[i - 1][j - 1] == '1') {
                table[i][j] = @min(table[i - 1][j], table[i][j - 1], table[i - 1][j - 1]) + 1;
                result = @max(table[i][j], result);
            }
        }
    }

    return result * result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const r1 = [_]u8{ '0', '1' };
    const r2 = [_]u8{ '1', '0' };

    const input = [_][]const u8{ &r1, &r2 };
    const expected = 1;

    const sol = try solution(allocator, &input);

    try expect(expected, sol);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const r1 = [_]u8{ '1', '0', '1', '0', '0' };
    const r2 = [_]u8{ '1', '0', '1', '1', '1' };
    const r3 = [_]u8{ '1', '1', '1', '1', '1' };
    const r4 = [_]u8{ '1', '0', '0', '1', '0' };

    const input = [_][]const u8{ &r1, &r2, &r3, &r4 };
    const expected = 4;

    const sol = try solution(allocator, &input);

    try expect(expected, sol);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const r1 = [_]u8{'0'};

    const input = [_][]const u8{&r1};
    const expected = 0;

    const sol = try solution(allocator, &input);

    try expect(expected, sol);
}
