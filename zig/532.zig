const std = @import("std");

fn findPairs(nums: []const i32, k: i32, alloc: std.mem.Allocator) !i32 {
    if (k < 0) return 0;

    var count: i32 = 0;

    var num_counts = std.AutoHashMap(i32, u32).init(alloc);
    defer num_counts.deinit();

    for (nums) |num| {
        const entry = try num_counts.getOrPutValue(num, 0);
        entry.value_ptr.* += 1;
    }

    var it = num_counts.iterator();
    while (it.next()) |entry| {
        const num = entry.key_ptr.*;
        const freq = entry.value_ptr.*;

        if (k == 0) {
            if (freq >= 2) {
                count += 1;
            }
        } else {
            if (num_counts.contains(num + k)) {
                count += 1;
            }
        }
    }

    return count;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const nums = [_]i32{ 3, 1, 4, 1, 5 };
    const k = 2;

    const result = try findPairs(&nums, k, alloc);
    try expect(result == 2);
}
