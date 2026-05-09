const std = @import("std");

fn solution(allocator: std.mem.Allocator, words1: []const []const u8, words2: []const []const u8) ![][]const u8 {
    var result: std.ArrayList([]const u8) = .empty;

    var freq = try allocator.alloc([]i32, words1.len);
    for (0..words1.len) |i| {
        freq[i] = try allocator.alloc(i32, 26);
        @memset(freq[i], 0);
    }

    for (0..words1.len) |i| {
        for (words1[i]) |c| {
            freq[i][c - 'a'] += 1;
        }
    }

    var uniFreq = try allocator.alloc(i32, 26);
    @memset(uniFreq, 0);
    defer {
        result.deinit(allocator);
        allocator.free(uniFreq);

        for (0..words1.len) |i| {
            allocator.free(freq[i]);
        }

        allocator.free(freq);
    }

    for (words2) |word| {
        var f = try allocator.alloc(i32, 26);
        defer allocator.free(f);
        @memset(f, 0);

        for (word) |c| {
            f[c - 'a'] += 1;
        }

        for (0..26) |i| {
            uniFreq[i] = @max(uniFreq[i], f[i]);
        }
    }

    for (0..words1.len) |i| {
        var flag: bool = true;

        for (0..26) |j| {
            if (freq[i][j] < uniFreq[j]) {
                flag = false;
                break;
            }
        }

        if (flag) {
            try result.append(allocator, words1[i]);
        }
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const words1 = [_][]const u8{ "amazon", "apple", "facebook", "google", "leetcode" };
    const words2 = [_][]const u8{ "e", "o" };

    const expected = [_][]const u8{ "facebook", "google", "leetcode" };
    const actual = try solution(allocator, &words1, &words2);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(std.mem.eql(u8, expected[i], actual[i]));
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const words1 = [_][]const u8{ "amazon", "apple", "facebook", "google", "leetcode" };
    const words2 = [_][]const u8{ "lc", "eo" };

    const expected = [_][]const u8{"leetcode"};
    const actual = try solution(allocator, &words1, &words2);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(std.mem.eql(u8, expected[i], actual[i]));
    }
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const words1 = [_][]const u8{ "acaac", "cccbb", "aacbb", "caacc", "bcbbb" };
    const words2 = [_][]const u8{ "c", "cc", "b" };

    const expected = [_][]const u8{"cccbb"};
    const actual = try solution(allocator, &words1, &words2);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);
    for (0..expected.len) |i| {
        try expect(std.mem.eql(u8, expected[i], actual[i]));
    }
}
