const std = @import("std");

fn backtrack(alloc: std.mem.Allocator, temp: *std.ArrayList(u8), result: *std.ArrayList([]u8), open: i32, close: i32) !void {
    if (open == 0 and close == 0) {
        const new_result = try alloc.alloc(u8, temp.items.len);
        @memcpy(new_result, temp.items);

        try result.append(new_result);
        return;
    }

    if (open > 0) {
        try temp.append('(');
        try backtrack(alloc, temp, result, open - 1, close);
        _ = temp.pop();
    }

    if (close > open) {
        try temp.append(')');
        try backtrack(alloc, temp, result, open, close - 1);
        _ = temp.pop();
    }
}

fn solution(alloc: std.mem.Allocator, n: i32) ![][]u8 {
    var result = std.ArrayList([]u8).init(alloc);
    defer result.deinit();

    var temp = std.ArrayList(u8).init(alloc);
    defer temp.deinit();

    try backtrack(alloc, &temp, &result, n, n);

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const sol = try solution(alloc, 3);
    defer {
        for (sol) |item| {
            alloc.free(item);
        }

        alloc.free(sol);
    }

    const expected = [_][]const u8{ "((()))", "(()())", "(())()", "()(())", "()()()" };

    try expect(sol.len == 5);

    for (0..sol.len) |idx| {
        try expect(std.mem.eql(u8, sol[idx], expected[idx]));
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const sol = try solution(alloc, 1);
    defer {
        for (sol) |item| {
            alloc.free(item);
        }

        alloc.free(sol);
    }

    try expect(sol.len == 1);
    try expect(std.mem.eql(u8, sol[0], "()"));
}
