const std = @import("std");

fn solution(allocator: std.mem.Allocator, encodedText: []const u8, rows: usize) ![]const u8 {
    var table = try allocator.alloc([]const u8, rows);
    var result: std.ArrayList(u8) = .empty;
    var idx: usize = 0;
    defer {
        for (0..rows) |i| {
            allocator.free(table[i]);
        }

        allocator.free(table);
        result.deinit(allocator);
    }

    const le = encodedText.len / rows;
    for (0..rows) |i| {
        var container: std.ArrayList(u8) = .empty;
        defer container.deinit(allocator);

        for (0..le) |j| {
            try container.append(allocator, encodedText[i * le + j]);
        }

        table[idx] = try container.toOwnedSlice(allocator);
        idx += 1;
    }

    for (0..le) |i| {
        for (0..rows) |j| {
            if (j >= rows or j + i >= le) {
                break;
            }

            try result.append(allocator, table[j][j + i]);
        }
    }

    const actual = try result.toOwnedSlice(allocator);

    var final_len = actual.len;
    while (final_len > 0 and actual[final_len - 1] == ' ') {
        final_len -= 1;
    }

    return allocator.realloc(actual, final_len);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const encodedText = "ch   ie   pr";
    const rows = 3;

    const expected = "cipher";
    const actual = try solution(allocator, encodedText, rows);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const encodedText = "iveo    eed   l te   olc";
    const rows = 4;

    const expected = "i love leetcode";
    const actual = try solution(allocator, encodedText, rows);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const encodedText = "coding";
    const rows = 1;

    const expected = "coding";
    const actual = try solution(allocator, encodedText, rows);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
