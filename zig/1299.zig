const std = @import("std");

fn solution(allocator: std.mem.Allocator, arr: []const i32) ![]i32 {
    var right = try allocator.alloc(i32, arr.len);
    right[arr.len - 1] = -1;

    var idx: usize = arr.len - 1;
    while (idx > 0) : (idx -= 1) {
        right[idx - 1] = @max(right[idx], arr[idx]);
    }

    return right;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{ 17, 18, 5, 4, 6, 1 };

    const expected = [_]i32{ 18, 6, 6, 6, 1, -1 };
    const actual = try solution(allocator, &arr);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{400};

    const expected = [_]i32{-1};
    const actual = try solution(allocator, &arr);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
