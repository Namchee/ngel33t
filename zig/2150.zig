const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) ![]i32 {
    var mp: std.AutoHashMap(i32, i32) = .init(allocator);
    defer mp.deinit();

    for (nums) |num| {
        const prev = mp.get(num);
        if (prev) |p| {
            try mp.put(num, p + 1);
        } else {
            try mp.put(num, 1);
        }
    }

    var result: std.ArrayList(i32) = .empty;
    defer result.deinit(allocator);

    var it = mp.iterator();

    while (it.next()) |entry| {
        if (entry.value_ptr.* > 1) {
            continue;
        }

        const left = mp.get(entry.key_ptr.* - 1);
        const right = mp.get(entry.key_ptr.* + 1);

        if (left == null and right == null) {
            try result.append(allocator, entry.key_ptr.*);
        }
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 10, 6, 5, 8 };

    const expected = [_]i32{ 8, 10 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 3, 5, 3 };

    const expected = [_]i32{ 5, 1 };
    const actual = try solution(allocator, &nums);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
