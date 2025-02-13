const std = @import("std");

fn solution(alloc: std.mem.Allocator, str: []const u8) !usize {
    var table = std.AutoHashMap(u8, bool).init(alloc);
    defer table.deinit();

    var left: usize = 0;
    var right: usize = 0;

    var result: usize = 0;

    while (right < str.len) {
        while (table.contains(str[right])) {
            _ = table.remove(str[left]);
            left += 1;
        }

        try table.put(str[right], true);

        result = @max(result, right - left + 1);
        right += 1;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = "abcabcbb";

    const sol = try solution(std.testing.allocator, input);

    try expect(sol == 3);
}

test "test case #2" {
    const input = "bbbbb";

    const sol = try solution(std.testing.allocator, input);

    try expect(sol == 1);
}

test "test case #3" {
    const input = "pwwkew";

    const sol = try solution(std.testing.allocator, input);

    try expect(sol == 3);
}
