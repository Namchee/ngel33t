const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) !i32 {
    var mp: std.AutoHashMap(i32, std.ArrayList(usize)) = .init(allocator);
    defer {
        var it = mp.iterator();

        while (it.next()) |entry| {
            entry.value_ptr.deinit(allocator);
        }

        mp.deinit();
    }

    for (nums, 0..) |num, idx| {
        if (mp.getPtr(num)) |entry| {
            try entry.append(allocator, idx);
        } else {
            var list: std.ArrayList(usize) = .empty;
            try list.append(allocator, idx);

            try mp.put(num, list);
        }
    }

    var it = mp.iterator();
    var best: i32 = -1;

    while (it.next()) |entry| {
        if (entry.value_ptr.items.len < 3) {
            continue;
        }

        for (0..entry.value_ptr.items.len - 2) |idx| {
            const a = entry.value_ptr.items[idx];
            const b = entry.value_ptr.items[idx + 1];
            const c = entry.value_ptr.items[idx + 2];

            const dist = b - a + c - b + c - a;
            if (best == -1 or dist < best) {
                best = @as(i32, @intCast(dist));
            }
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 1, 2, 1, 1, 3 };

    const expected = 6;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 1, 1, 2, 3, 2, 1, 2 };

    const expected = 8;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;
    const nums = [_]i32{1};

    const expected = -1;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}
