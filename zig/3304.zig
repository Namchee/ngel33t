const std = @import("std");

fn solution(allocator: std.mem.Allocator, k: usize) !u8 {
    var word = try allocator.dupe(u8, "a");
    const letters = "abcdefghijklmnopqrstuvwxyz";

    while (word.len < k) {
        var temp = try allocator.alloc(u8, word.len * 2);

        for (word, 0..) |c, idx| {
            temp[idx] = c;
            temp[idx + word.len] = letters[(c - 'a' + 1) % 26];
        }

        allocator.free(word);

        word = temp;
    }

    defer allocator.free(word);
    return word[k - 1];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const k = 5;

    const expected = 'b';
    const actual = try solution(allocator, k);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const k = 10;

    const expected = 'c';
    const actual = try solution(allocator, k);

    try expect(expected, actual);
}
