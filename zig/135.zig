const std = @import("std");

fn solution(alloc: std.mem.Allocator, ratings: []i32) !i32 {
    var candies = try std.ArrayListUnmanaged(i32).initCapacity(alloc, ratings.len);
    try candies.resize(alloc, ratings.len);

    defer candies.deinit(alloc);

    for (0..ratings.len) |idx| {
        candies.items[idx] = 1;
    }

    var idx: usize = 1;

    while (idx < ratings.len) : (idx += 1) {
        if (ratings[idx] > ratings[idx - 1]) {
            candies.items[idx] = candies.items[idx - 1] + 1;
        }
    }

    idx = ratings.len - 1;

    while (idx > 0) {
        idx -= 1;
        if (ratings[idx] > ratings[idx + 1]) {
            candies.items[idx] = @max(candies.items[idx], candies.items[idx + 1] + 1);
        }
    }

    var count: i32 = 0;
    for (candies.items) |c| {
        count += c;
    }

    return count;
}

const expect = std.testing.expect;

test "test case #1" {
    var ratings = [_]i32{ 1, 0, 2 };

    const sol = try solution(std.testing.allocator, &ratings);

    try expect(sol == 5);
}

test "test case #2" {
    var ratings = [_]i32{ 1, 2, 2 };

    const sol = try solution(std.testing.allocator, &ratings);

    try expect(sol == 4);
}
