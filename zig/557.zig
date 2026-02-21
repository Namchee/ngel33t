const std = @import("std");

fn solution(s: []const u8, alloc: std.mem.Allocator) ![]const u8 {
    const result = try alloc.alloc(u8, s.len);
    errdefer alloc.free(result);

    var it = std.mem.splitAny(u8, s, " ");
    var write_idx: usize = 0;

    while (it.next()) |token| {
        var i: usize = 0;
        while (i < token.len) : (i += 1) {
            result[write_idx + i] = token[token.len - 1 - i];
        }
        write_idx += token.len;

        if (write_idx < result.len) {
            result[write_idx] = ' ';
            write_idx += 1;
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;
    const input = "Let's take LeetCode contest";
    const expected = "s'teL ekat edoCteeL tsetnoc";

    const sol = try solution(input, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}

test "test case #2" {
    const alloc = std.testing.allocator;
    const input = "Mr Ding";
    const expected = "rM gniD";

    const sol = try solution(input, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}
