const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8) ![]const u8 {
    var freq = std.AutoHashMap(u8, usize).init(allocator);
    defer freq.deinit();

    for (s) |ch| {
        const entry = try freq.getOrPutValue(ch, 0);
        entry.value_ptr.* += 1;
    }

    var best = std.AutoHashMap(usize, std.ArrayList(u8)).init(allocator);
    defer {
        var it = best.valueIterator();
        while (it.next()) |list| {
            list.deinit(allocator);
        }

        best.deinit();
    }

    var max_group_size: usize = 0;
    var best_freq: usize = 0;

    var it = freq.iterator();
    while (it.next()) |entry| {
        const char = entry.key_ptr.*;
        const count = entry.value_ptr.*;

        const group_entry = try best.getOrPut(count);
        if (!group_entry.found_existing) {
            group_entry.value_ptr.* = .empty;
        }
        try group_entry.value_ptr.append(allocator, char);

        const current_group_size = group_entry.value_ptr.items.len;

        if (current_group_size > max_group_size or (current_group_size == max_group_size and count > best_freq)) {
            max_group_size = current_group_size;
            best_freq = count;
        }
    }

    if (best.get(best_freq)) |winner| {
        return try allocator.dupe(u8, winner.items);
    }

    return try allocator.dupe(u8, "");
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s = "aaabbbccdddde";

    const expected = "ba";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s = "abcd";

    const expected = "bacd";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
