const std = @import("std");

fn twoEdit(a: []const u8, b: []const u8) bool {
    var diff: usize = 0;

    for (0..a.len) |i| {
        if (a[i] != b[i]) {
            diff += 1;
        }
    }

    return diff <= 2;
}

fn solution(allocator: std.mem.Allocator, queries: []const []const u8, dictionary: []const []const u8) ![][]const u8 {
    var result: std.ArrayList([]const u8) = .empty;
    defer result.deinit(allocator);

    for (queries) |q| {
        for (dictionary) |d| {
            if (q.len == d.len and twoEdit(q, d)) {
                try result.append(allocator, q);
            }
        }
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const queries = [_][]const u8{ "word", "note", "ants", "wood" };
    const dictionary = [_][]const u8{ "wood", "joke", "moat" };

    const expected = [_][]const u8{ "word", "note", "wood" };
    const actual = try solution(allocator, &queries, &dictionary);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(std.mem.eql(u8, expected[i], actual[i]));
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const queries = [_][]const u8{"yes"};
    const dictionary = [_][]const u8{"not"};

    const expected = [_][]const u8{};
    const actual = try solution(allocator, &queries, &dictionary);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(std.mem.eql(u8, expected[i], actual[i]));
    }
}
