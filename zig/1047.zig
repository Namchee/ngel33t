const std = @import("std");

fn solution(str: []const u8, alloc: std.mem.Allocator) ![]const u8 {
    var stack: std.ArrayList(u8) = .empty;
    defer stack.deinit(alloc);

    for (str) |ch| {
        if (stack.items.len == 0) {
            try stack.append(alloc, ch);
            continue;
        }

        if (stack.items[stack.items.len - 1] == ch) {
            _ = stack.pop();
        } else {
            try stack.append(alloc, ch);
        }
    }

    return stack.toOwnedSlice(alloc);
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;
    const input = "abbaca";
    const expected = "ca";

    const sol = try solution(input, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}

test "test case #2" {
    const alloc = std.testing.allocator;
    const input = "azxxzy";
    const expected = "ay";

    const sol = try solution(input, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}
