const std = @import("std");

const mp = [_][]const u8{
    "abc",
    "def",
    "ghi",
    "jkl",
    "mno",
    "pqrs",
    "tuv",
    "wxyz",
};

fn backtrack(alloc: std.mem.Allocator, idx: usize, digits: []const u8, curr: *std.ArrayList(u8), result: *std.ArrayList([]const u8)) !void {
    if (idx >= digits.len) {
        const str = try alloc.dupe(u8, curr.items);

        try result.append(str);
        return;
    }

    for (mp[digits[idx] - '2']) |c| {
        try curr.append(c);
        try backtrack(alloc, idx + 1, digits, curr, result);
        _ = curr.pop();
    }
}

fn solution(alloc: std.mem.Allocator, digits: []const u8) ![][]const u8 {
    var ans = std.ArrayList([]const u8).init(alloc);
    defer {
        for (ans.items) |item| {
            alloc.free(item);
        }

        ans.deinit();
    }

    if (digits.len == 0) {
        return ans.toOwnedSlice();
    }

    var buffer = std.ArrayList(u8).init(alloc);
    defer buffer.deinit();

    try backtrack(alloc, 0, digits, &buffer, &ans);

    return ans.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const input = "23";
    const sol = try solution(alloc, input);

    defer {
        for (sol) |s| {
            alloc.free(s);
        }

        alloc.free(sol);
    }

    const expected = [_][]const u8{ "ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf" };

    for (0..expected.len) |idx| {
        try expect(std.mem.eql(u8, sol[idx], expected[idx]));
    }
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const input = "2";
    const sol = try solution(alloc, input);

    defer {
        for (sol) |s| {
            alloc.free(s);
        }

        alloc.free(sol);
    }

    const expected = [_][]const u8{ "a", "b", "c" };

    for (0..expected.len) |idx| {
        try expect(std.mem.eql(u8, sol[idx], expected[idx]));
    }
}

test "test case #3" {
    const alloc = std.testing.allocator;

    const input = "";
    const sol = try solution(alloc, input);

    defer {
        for (sol) |s| {
            alloc.free(s);
        }

        alloc.free(sol);
    }

    const expected = [_][]const u8{};

    for (0..expected.len) |idx| {
        try expect(std.mem.eql(u8, sol[idx], expected[idx]));
    }
}
