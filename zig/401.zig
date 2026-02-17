const std = @import("std");

fn generate(idx: usize, count: usize, curr: usize, combination: *std.ArrayList([]const u8), alloc: std.mem.Allocator) !void {
    if (count == 0) {
        var hour: usize = 0;
        var minutes: usize = 0;

        for (0..4) |val| {
            if (curr & (@as(usize, 1) << @as(u6, @intCast(6 + val))) > 0) {
                hour |= (@as(usize, 1) << @as(u6, @intCast(val)));
            }
        }

        for (0..6) |val| {
            if (curr & (@as(usize, 1) << @as(u6, @intCast(val))) > 0) {
                minutes |= (@as(usize, 1) << @as(u6, @intCast(val)));
            }
        }

        if (hour <= 11 and minutes <= 59) {
            const s = try std.fmt.allocPrint(alloc, "{d}:{d:0>2}", .{ hour, minutes });
            try combination.append(alloc, s);
        }

        return;
    }

    if (idx > 9) {
        return;
    }

    try generate(idx + 1, count - 1, curr | (@as(usize, 1) << @as(u6, @intCast(idx))), combination, alloc);
    try generate(idx + 1, count, curr, combination, alloc);
}

fn solution(turnedOn: u32, alloc: std.mem.Allocator) !std.ArrayList([]const u8) {
    var possible: std.ArrayList([]const u8) = .empty;

    if (turnedOn > 10) {
        return possible;
    }

    try generate(0, turnedOn, 0, &possible, alloc);

    return possible;
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "0 LEDs" {
    const alloc = std.testing.allocator;
    var result = try solution(0, alloc);
    defer {
        for (result.items) |s| alloc.free(s);
        result.deinit(alloc);
    }

    try expect(result.items.len == 1);
    try expect(std.mem.eql(u8, result.items[0], "0:00"));
}

test "1 LED" {
    const alloc = std.testing.allocator;
    var result = try solution(1, alloc);
    defer {
        for (result.items) |s| alloc.free(s);
        result.deinit(alloc);
    }

    const expected = [_][]const u8{ "0:01", "0:02", "0:04", "0:08", "0:16", "0:32", "1:00", "2:00", "4:00", "8:00" };
    try expect(result.items.len == expected.len);
    for (expected, result.items) |e, r| {
        try expect(std.mem.eql(u8, e, r));
    }
}

test "9 LEDs" {
    const alloc = std.testing.allocator;
    var result = try solution(9, alloc);
    defer {
        for (result.items) |s| alloc.free(s);
        result.deinit(alloc);
    }

    try expect(result.items.len == 0);
}
