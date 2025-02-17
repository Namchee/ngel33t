const std = @import("std");

const Entry = struct { i32, []const u8 };

fn solution(alloc: std.mem.Allocator, intervals: [][2]i32) ![][2]i32 {
    var result = std.ArrayList([2]i32).init(alloc);
    defer result.deinit();

    var curr = intervals[0];

    for (1..intervals.len) |idx| {
        if (curr[0] <= intervals[idx][0] and curr[1] >= intervals[idx][0]) {
            curr[1] = intervals[idx][1];
        } else {
            try result.append(curr);
            curr = intervals[idx];
        }
    }

    try result.append(curr);

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;
    var intervals = [_][2]i32{
        .{ 1, 3 },
        .{ 2, 6 },
        .{ 8, 10 },
        .{ 15, 18 },
    };

    const sol = try solution(alloc, &intervals);
    defer alloc.free(sol);

    try expect(sol[0][0] == 1);
    try expect(sol[0][1] == 6);
    try expect(sol[1][0] == 8);
    try expect(sol[1][1] == 10);
    try expect(sol[2][0] == 15);
    try expect(sol[2][1] == 18);
}

test "test case #2" {
    const alloc = std.testing.allocator;
    var intervals = [_][2]i32{
        .{ 1, 4 },
        .{ 4, 5 },
    };

    const sol = try solution(alloc, &intervals);
    defer alloc.free(sol);

    try expect(sol[0][0] == 1);
    try expect(sol[0][1] == 5);
}
