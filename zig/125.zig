const std = @import("std");

fn solution(alloc: std.mem.Allocator, str: []const u8) !bool {
    var arr = std.ArrayList(u8).init(alloc);
    defer arr.deinit();

    for (str) |el| {
        if (std.ascii.isAlphanumeric(el)) {
            try arr.append(std.ascii.toLower(el));
        }
    }

    for (0..arr.items.len / 2) |idx| {
        if (arr.items[idx] != arr.items[arr.items.len - 1 - idx]) {
            return false;
        }
    }

    return true;
}

const expect = std.testing.expect;

test "test case #1" {
    const str = "A man, a plan, a canal: Panama";
    const result = try solution(std.testing.allocator, str);

    try expect(result);
}

test "test case #2" {
    const str = "race a car";
    const result = try solution(std.testing.allocator, str);

    try expect(!result);
}

test "test case #3" {
    const str = " ";
    const result = try solution(std.testing.allocator, str);

    try expect(result);
}
