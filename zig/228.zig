const std = @import("std");

fn solution(alloc: std.mem.Allocator, nums: []i32) ![][]const u8 {
    var temp = std.ArrayList([]const u8).init(alloc);
    defer temp.deinit();

    var begin: i32 = nums[0];
    var prev: i32 = nums[0];

    for (1..nums.len) |idx| {
        if (@abs(nums[idx] - prev) > 1) {
            const formatted = if (begin == prev)
                try std.fmt.allocPrint(alloc, "{d}", .{begin})
            else
                try std.fmt.allocPrint(alloc, "{d}->{d}", .{ begin, prev });

            try temp.append(
                formatted,
            );

            begin = nums[idx];
        }

        prev = nums[idx];
    }

    const formatted = if (begin == prev)
        try std.fmt.allocPrint(alloc, "{d}", .{begin})
    else
        try std.fmt.allocPrint(alloc, "{d}->{d}", .{ begin, prev });

    try temp.append(
        formatted,
    );

    return temp.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 0, 1, 2, 4, 5, 7 };

    const alloc = std.testing.allocator;
    const sol = try solution(alloc, &nums);

    defer {
        for (sol) |item| {
            alloc.free(item);
        }
        alloc.free(sol);
    }

    try expect(std.mem.eql(u8, sol[0], "0->2"));
    try expect(std.mem.eql(u8, sol[1], "4->5"));
    try expect(std.mem.eql(u8, sol[2], "7"));
}

test "test case #2" {
    var nums = [_]i32{ 0, 2, 3, 4, 6, 8, 9 };

    const alloc = std.testing.allocator;
    const sol = try solution(alloc, &nums);

    defer {
        for (sol) |item| {
            alloc.free(item);
        }
        alloc.free(sol);
    }

    try expect(std.mem.eql(u8, sol[0], "0"));
    try expect(std.mem.eql(u8, sol[1], "2->4"));
    try expect(std.mem.eql(u8, sol[2], "6"));
    try expect(std.mem.eql(u8, sol[3], "8->9"));
}
