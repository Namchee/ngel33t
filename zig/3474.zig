const std = @import("std");

fn solution(allocator: std.mem.Allocator, str1: []const u8, str2: []const u8) ![]const u8 {
    const n = str1.len;
    const m = str2.len;

    var s = try allocator.alloc(u8, n + m - 1);
    for (0..n + m - 1) |i| {
        s[i] = 'a';
    }

    var fixed = try allocator.alloc(bool, n + m - 1);
    @memset(fixed, false);
    defer allocator.free(fixed);

    for (0..n) |i| {
        if (str1[i] == 'T') {
            for (i..i + m) |j| {
                if (fixed[j] and s[j] != str2[j - i]) {
                    allocator.free(s);
                    return "";
                } else {
                    s[j] = str2[j - i];
                    fixed[j] = true;
                }
            }
        }
    }

    for (0..n) |i| {
        if (str1[i] == 'F') {
            var flag: bool = false;
            var idx: i32 = -1;
            var j = i + m - 1;

            while (j >= i and !flag) : (j -= 1) {
                if (str2[j - i] != s[j]) {
                    flag = true;
                    break;
                }

                if (idx == -1 and !fixed[j]) {
                    idx = @as(i32, @intCast(j));
                }
            }

            if (flag) {
                continue;
            }

            if (idx == -1) {
                allocator.free(s);
                return "";
            }

            s[@as(usize, @intCast(idx))] = 'b';
        }
    }

    return s;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const str1 = "TFTF";
    const str2 = "ab";

    const expected = "ababa";
    const actual = try solution(allocator, str1, str2);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const str1 = "TFTF";
    const str2 = "abc";

    const expected = "";
    const actual = try solution(allocator, str1, str2);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const str1 = "F";
    const str2 = "d";

    const expected = "a";
    const actual = try solution(allocator, str1, str2);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
