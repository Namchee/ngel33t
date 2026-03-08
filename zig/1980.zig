const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const []const u8) ![]const u8 {
    var container: std.ArrayList(u8) = .empty;
    defer container.deinit(allocator);

    for (0..nums.len) |idx| {
        if (nums[idx][idx] == '0') {
            try container.append(allocator, '1');
        } else {
            try container.append(allocator, '0');
        }
    }

    return container.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_][]const u8{ "01", "10" };
    const expected = "11";

    const sol = try solution(allocator, &nums);
    defer allocator.free(sol);

    try expect(std.mem.eql(u8, expected, sol));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_][]const u8{ "00", "01" };
    const expected = "10";

    const sol = try solution(allocator, &nums);
    defer allocator.free(sol);

    try expect(std.mem.eql(u8, expected, sol));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const nums = [_][]const u8{ "111", "011", "001" };
    const expected = "000";

    const sol = try solution(allocator, &nums);
    defer allocator.free(sol);

    try expect(std.mem.eql(u8, expected, sol));
}
