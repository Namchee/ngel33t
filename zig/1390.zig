const std = @import("std");

fn solution(nums: []i32, alloc: std.mem.Allocator) !i32 {
    var result: i32 = 0;

    for (nums) |num| {
        var temp: std.ArrayList(i32) = .empty;
        defer temp.deinit(alloc);

        var div: i32 = 1;

        const limit: i32 = @intFromFloat(@sqrt(@as(f64, @floatFromInt(num))));

        while (div <= limit) {
            if (@mod(num, div) == 0) {
                try temp.append(alloc, div);

                if (@divExact(num, div) != div) {
                    try temp.append(alloc, @divExact(num, div));
                }
            }

            div += 1;
        }

        if (temp.items.len == 4) {
            for (temp.items) |n| {
                result += n;
            }
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 21, 4, 7 };
    const expected = 32;

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 21, 21 };
    const expected = 64;

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}

test "test case #3" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 1, 2, 3, 4, 5 };
    const expected = 0;

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}
