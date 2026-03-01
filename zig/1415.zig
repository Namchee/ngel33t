const std = @import("std");

const set = [_]u8{ 'a', 'b', 'c' };

fn generate(idx: usize, container: []u8, result: *std.ArrayList([]const u8), alloc: std.mem.Allocator) !void {
    if (idx == container.len) {
        const entry = try alloc.dupe(u8, container);

        try result.append(alloc, entry);

        return;
    }

    for (set) |ch| {
        if (idx == 0 or container[idx - 1] != ch) {
            container[idx] = ch;
            try generate(idx + 1, container, result, alloc);
        }
    }
}

fn solution(n: usize, k: usize, alloc: std.mem.Allocator) ![]const u8 {
    const container = try alloc.alloc(u8, n);
    defer alloc.free(container);
    var result: std.ArrayList([]const u8) = .empty;
    errdefer {
        for (result.items) |item| alloc.free(item);
        result.deinit(alloc);
    }

    try generate(0, container, &result, alloc);

    if (k == 0 or k > result.items.len) {
        for (result.items) |item| alloc.free(item);

        result.deinit(alloc);
        return "";
    }

    const final_str = result.items[k - 1];

    for (result.items, 0..) |item, i| {
        if (i != k - 1) alloc.free(item);
    }
    result.deinit(alloc);

    return final_str;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const n = 1;
    const k = 3;
    const expected = "c";

    const sol = try solution(n, k, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const n = 1;
    const k = 4;
    const expected = "";

    const sol = try solution(n, k, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}

test "test case #3" {
    const alloc = std.testing.allocator;

    const n = 3;
    const k = 9;
    const expected = "cab";

    const sol = try solution(n, k, alloc);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, expected));
}
