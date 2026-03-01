const std = @import("std");
const Allocator = std.mem.Allocator;

fn generate(
    idx: usize,
    buf: []u8,
    result: *std.ArrayList([]const u8),
    alloc: Allocator,
) !void {
    if (idx == buf.len) {
        const copy = try alloc.dupe(u8, buf);
        try result.append(alloc, copy);
        return;
    }

    const char = buf[idx];

    if (std.ascii.isAlphabetic(char)) {
        buf[idx] = std.ascii.toUpper(char);
        try generate(idx + 1, buf, result, alloc);
        buf[idx] = std.ascii.toLower(char);
        try generate(idx + 1, buf, result, alloc);
    } else {
        try generate(idx + 1, buf, result, alloc);
    }
}

pub fn letterCasePermutation(alloc: Allocator, s: []const u8) ![][]const u8 {
    var result: std.ArrayList([]const u8) = .empty;
    errdefer {
        for (result.items) |item| alloc.free(item);
        result.deinit(alloc);
    }

    const buf = try alloc.dupe(u8, s);
    defer alloc.free(buf);

    try generate(0, buf, &result, alloc);

    return result.toOwnedSlice(alloc);
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const input = "a1b2";
    const expected = [_][]const u8{ "a1b2", "a1B2", "A1b2", "A1B2" };

    const actual = try letterCasePermutation(alloc, input);

    defer {
        for (actual) |item| alloc.free(item);
        alloc.free(actual);
    }

    try expect(actual.len == expected.len);

    for (expected) |exp| {
        var found = false;

        for (actual) |act| {
            if (std.mem.eql(u8, exp, act)) {
                found = true;
                break;
            }
        }

        if (!found) {
            std.debug.print("Could not find expected string: {s}\n", .{exp});
            return error.TestExpectedStringNotFound;
        }
    }
}
