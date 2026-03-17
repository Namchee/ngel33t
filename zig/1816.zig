const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8, k: usize) ![]const u8 {
    var container = try allocator.alloc([]const u8, k);
    defer allocator.free(container);
    var it = std.mem.splitScalar(u8, s, ' ');

    var idx: usize = 0;

    while (it.next()) |val| {
        container[idx] = val;
        idx += 1;

        if (idx >= k) {
            break;
        }
    }

    return std.mem.join(allocator, " ", container);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s = "Hello how are you Contestant";
    const k = 4;

    const expected = "Hello how are you";
    const actual = try solution(allocator, s, k);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s = "What is the solution to this problem";
    const k = 4;

    const expected = "What is the solution";
    const actual = try solution(allocator, s, k);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const s = "chopper is not a tanuki";
    const k = 5;

    const expected = "chopper is not a tanuki";
    const actual = try solution(allocator, s, k);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
