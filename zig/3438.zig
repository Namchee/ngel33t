const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8) ![]const u8 {
    var freq: std.AutoHashMap(u8, i32) = .init(allocator);
    defer freq.deinit();

    for (s) |c| {
        if (freq.get(c)) |val| {
            try freq.put(c, val + 1);
        } else {
            try freq.put(c, 1);
        }
    }

    for (1..s.len) |i| {
        const a = s[i];
        const b = s[i - 1];
        const freqA = freq.get(a);
        const freqB = freq.get(b);
        const vA = @as(i32, @intCast(a - '0'));
        const vB = @as(i32, @intCast(b - '0'));

        if (a != b and vA == freqA and vB == freqB) {
            const res = try std.fmt.allocPrint(allocator, "{c}{c}", .{ b, a });

            return res;
        }
    }

    return "";
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s = "2523533";

    const expected = "23";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s = "221";

    const expected = "21";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const s = "22";

    const expected = "";
    const actual = try solution(allocator, s);

    try expect(std.mem.eql(u8, expected, actual));
}
