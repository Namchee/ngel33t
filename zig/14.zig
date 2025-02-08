const std = @import("std");

fn solution(alloc: std.mem.Allocator, arr: [][]const u8) ![]const u8 {
    var idx: usize = 0;

    var container = std.ArrayList(u8).init(alloc);
    defer container.deinit();

    while (idx < arr[0].len) {
        const base = arr[0][idx];

        for (1..arr.len) |it| {
            if (idx >= arr[it].len or arr[it][idx] != base) {
                if (container.items.len == 0) {
                    return "";
                }

                return container.toOwnedSlice();
            }
        }

        try container.append(base);
        idx += 1;
    }

    return container.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    var arr = [_][]const u8{ "flower", "flow", "flight" };

    const sol = try solution(std.testing.allocator, &arr);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, "fl", sol));
}

test "test case #2" {
    var arr = [_][]const u8{ "dog", "racecar", "car" };

    const sol = try solution(std.testing.allocator, &arr);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, "", sol));
}
