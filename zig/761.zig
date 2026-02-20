const std = @import("std");

fn comparator(_: void, a: []const u8, b: []const u8) bool {
    return std.mem.order(u8, a, b) == .gt;
}

fn solution(str: []const u8, alloc: std.mem.Allocator) ![]const u8 {
    if (str.len == 0) {
        return "";
    }

    var buffer: std.ArrayList([]const u8) = .empty;
    var balance: usize = 0;
    var start: usize = 0;
    defer {
        for (buffer.items) |item| {
            alloc.free(item);
        }

        buffer.deinit(alloc);
    }

    for (str, 0..) |ch, idx| {
        if (ch == '1') {
            balance += 1;
        } else {
            balance -= 1;
        }

        if (balance == 0) {
            const inner = try solution(str[start + 1 .. idx], alloc);
            defer alloc.free(inner);

            const temp = try std.fmt.allocPrint(alloc, "1{s}0", .{inner});
            try buffer.append(alloc, temp);
            start = idx + 1;
        }
    }

    std.mem.sort([]const u8, buffer.items, {}, comparator);

    return std.mem.join(alloc, "", buffer.items);
}

const expect = std.testing.expect;

test "test case #1" {
    const input = "11011000";
    const expected = "11100100";

    const sol = try solution(input, std.testing.allocator);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}

test "test case #2" {
    const input = "10";
    const expected = "10";

    const sol = try solution(input, std.testing.allocator);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}
