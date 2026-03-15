const std = @import("std");

fn getMinutes(str: []const u8) !i32 {
    var tokens = [2][]const u8{ "", "" };
    var it = std.mem.splitScalar(u8, str, ':');

    var idx: usize = 0;
    while (it.next()) |v| {
        tokens[idx] = v;
        idx += 1;
    }

    var hour = try std.fmt.parseInt(i32, tokens[0], 10);
    hour *= 60;

    const minutes = try std.fmt.parseInt(i32, tokens[1], 10);

    return minutes + hour;
}

fn solution(allocator: std.mem.Allocator, timeStrings: []const []const u8) !i32 {
    var temp = try allocator.alloc(i32, timeStrings.len);
    defer allocator.free(temp);

    for (timeStrings, 0..) |s, i| {
        temp[i] = try getMinutes(s);
    }

    std.mem.sort(i32, temp, {}, std.sort.asc(i32));

    var result = temp[1] - temp[0];

    for (2..temp.len) |idx| {
        result = @min(result, temp[idx] - temp[idx - 1]);
    }

    return @min(result, 24 * 60 - temp[temp.len - 1] + temp[0]);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const input = [_][]const u8{ "23:59", "00:00" };

    const expected = 1;
    const actual = try solution(allocator, &input);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const input = [_][]const u8{ "00:00", "23:59", "00:00" };

    const expected = 0;
    const actual = try solution(allocator, &input);

    try expect(expected, actual);
}
