const std = @import("std");

const equal = std.mem.eql;

fn solution(path: []const u8, alloc: std.mem.Allocator) ![]const u8 {
    var it = std.mem.tokenizeScalar(u8, path, '/');
    var container: std.ArrayList([]const u8) = .empty;
    defer container.deinit(alloc);

    while (it.next()) |token| {
        if (token.len == 0 or equal(u8, ".", token)) {
            continue;
        }

        if (equal(u8, "..", token)) {
            _ = container.pop();
        } else {
            try container.append(alloc, token);
        }
    }

    const result = try container.toOwnedSlice(alloc);
    const newPath = try std.mem.join(alloc, "/", result);
    defer {
        alloc.free(result);
        alloc.free(newPath);
    }

    return std.fmt.allocPrint(alloc, "/{s}", .{newPath});
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const path = "/home/";
    const expected = "/home";

    const sol = try solution(path, alloc);
    defer alloc.free(sol);

    try expect(equal(u8, sol, expected));
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const path = "/home//foo/";
    const expected = "/home/foo";

    const sol = try solution(path, alloc);
    defer alloc.free(sol);

    try expect(equal(u8, sol, expected));
}

test "test case #3" {
    const alloc = std.testing.allocator;

    const path = "/../";
    const expected = "/";

    const sol = try solution(path, alloc);
    defer alloc.free(sol);

    try expect(equal(u8, sol, expected));
}

test "test case #4" {
    const alloc = std.testing.allocator;

    const path = "/.../a/../b/c/../d/./";
    const expected = "/.../b/d";

    const sol = try solution(path, alloc);
    defer alloc.free(sol);

    try expect(equal(u8, sol, expected));
}
