const std = @import("std");

fn solution(allocator: std.mem.Allocator, word1: []const u8, word2: []const u8) !usize {
    const n = word1.len;
    const m = word2.len;

    var dp = try allocator.alloc([]usize, n + 1);
    for (0..n + 1) |idx| {
        dp[idx] = try allocator.alloc(usize, m + 1);
    }

    defer {
        for (0..n + 1) |i| {
            allocator.free(dp[i]);
        }

        allocator.free(dp);
    }

    for (0..n + 1) |i| {
        dp[i][0] = i;
    }

    for (0..m + 1) |j| {
        dp[0][j] = j;
    }

    for (1..n + 1) |i| {
        for (1..m + 1) |j| {
            if (word1[i - 1] == word2[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1];
            } else {
                dp[i][j] = @min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1;
            }
        }
    }

    return dp[n][m];
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const word1 = "horse";
    const word2 = "ros";

    const expected = 3;

    const sol = try solution(allocator, word1, word2);

    try expect(sol == expected);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const word1 = "intention";
    const word2 = "execution";

    const expected = 5;

    const sol = try solution(allocator, word1, word2);

    try expect(sol == expected);
}
