const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8) ![]const u8 {
    var occ = [_]usize{0} ** 256;
    var seen = [_]bool{false} ** 256;

    for (s, 0..) |ch, i| {
        occ[ch] = i;
    }

    var stack: std.ArrayList(u8) = .empty;
    defer {
        stack.deinit(allocator);
    }

    for (s, 0..) |ch, idx| {
        if (!seen[ch]) {
            while (stack.items.len > 0 and ch < stack.getLast() and occ[stack.getLast()] > idx) {
                const top = stack.pop().?;
                seen[top] = false;
            }

            try stack.append(allocator, ch);
            seen[ch] = true;
        }
    }

    return stack.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;
    const s = "bcabc";

    const expected = "abc";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const s = "cbacdcbc";

    const expected = "acdb";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
