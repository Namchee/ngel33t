const std = @import("std");

fn solution(alloc: std.mem.Allocator, nums: []i32) !usize {
    var ans: usize = 0;

    var mp = std.AutoHashMap(i32, bool).init(alloc);
    defer mp.deinit();

    for (nums) |num| {
        try mp.put(num, true);
    }

    var it = mp.keyIterator();

    while (it.next()) |k| {
        const prev = k.* - 1;

        if (!mp.contains(prev)) {
            var len: usize = 1;

            while (mp.contains(k.* + @as(i32, @intCast(len)))) {
                len += 1;
            }

            ans = @max(ans, len);
        }
    }

    return ans;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 100, 4, 200, 1, 3, 2 };
    const alloc = std.testing.allocator;

    const sol = try solution(alloc, &nums);

    try expect(sol == 4);
}

test "test case #2" {
    var nums = [_]i32{ 0, 3, 7, 2, 5, 8, 4, 6, 0, 1 };
    const alloc = std.testing.allocator;

    const sol = try solution(alloc, &nums);

    try expect(sol == 9);
}
