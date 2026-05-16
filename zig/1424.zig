const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const []const i32) ![]i32 {
    var diagonals: std.ArrayList(std.ArrayList(i32)) = .empty;

    defer {
        for (0..diagonals.items.len) |i| {
            diagonals.items[i].deinit(allocator);
        }

        diagonals.deinit(allocator);
    }

    for (nums, 0..) |row, x| {
        for (row, 0..) |val, y| {
            const diag_index = x + y;

            while (diagonals.items.len <= diag_index) {
                try diagonals.append(allocator, .empty);
            }

            try diagonals.items[diag_index].append(allocator, val);
        }
    }

    var result: std.ArrayList(i32) = .empty;
    defer result.deinit(allocator);

    for (diagonals.items) |diag| {
        var i = diag.items.len;
        while (i > 0) {
            i -= 1;
            try result.append(allocator, diag.items[i]);
        }
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_][]const i32{
        &[_]i32{ 1, 2, 3 },
        &[_]i32{ 4, 5, 6 },
        &[_]i32{ 7, 8, 9 },
    };

    const expected = [_]i32{ 1, 4, 2, 7, 5, 3, 8, 6, 9 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_][]const i32{ &[_]i32{ 1, 2, 3, 4, 5 }, &[_]i32{ 6, 7 }, &[_]i32{8}, &[_]i32{ 9, 10, 11 }, &[_]i32{ 12, 13, 14, 15, 16 } };

    const expected = [_]i32{ 1, 6, 2, 8, 7, 3, 9, 4, 12, 10, 5, 13, 11, 14, 15, 16 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
