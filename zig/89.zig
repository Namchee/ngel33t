const std = @import("std");

fn solution(allocator: std.mem.Allocator, n: u5) ![]i32 {
    const lim: usize = @as(u32, 1) << @as(u5, n);

    var result = try allocator.alloc(i32, lim);

    for (0..lim) |i| {
        result[i] = @as(i32, @intCast(i ^ (i >> 1)));
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const input = 2;
    const expected = [_]i32{ 0, 1, 3, 2 };

    const sol = try solution(allocator, input);
    defer allocator.free(sol);

    try expect(expected.len, sol.len);

    for (0..sol.len) |i| {
        try expect(expected[i], sol[i]);
    }
}
