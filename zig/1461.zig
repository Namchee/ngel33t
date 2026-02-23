const std = @import("std");

fn solution(s: []const u8, k: usize, alloc: std.mem.Allocator) !bool {
    var table: std.StringHashMap(bool) = .init(alloc);
    defer table.deinit();

    for (0..s.len - k + 1) |idx| {
        const sub = s[idx .. idx + k];
        try table.put(sub, true);
    }

    return table.count() == std.math.pow(u64, 2, k);
}

const expect = std.testing.expect;

test "test case #1" {
    const s = "00110110";
    const k = 2;

    const alloc = std.testing.allocator;

    const expected = true;
    const sol = try solution(s, k, alloc);

    try expect(sol == expected);
}

test "test case #2" {
    const s = "0110";
    const k = 1;

    const alloc = std.testing.allocator;

    const expected = true;
    const sol = try solution(s, k, alloc);

    try expect(sol == expected);
}

test "test case #3" {
    const s = "0110";
    const k = 2;

    const alloc = std.testing.allocator;

    const expected = false;
    const sol = try solution(s, k, alloc);

    try expect(sol == expected);
}
