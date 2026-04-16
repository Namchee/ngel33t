const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32, queries: []const usize) ![]i32 {
    var best = try allocator.alloc(i32, nums.len);
    var result = try allocator.alloc(i32, queries.len);
    @memset(best, 1000000007);

    const len = @as(i32, @intCast(nums.len));

    var first: std.AutoHashMap(i32, i32) = .init(allocator);
    var prev: std.AutoHashMap(i32, i32) = .init(allocator);

    defer {
        first.deinit();
        prev.deinit();

        allocator.free(best);
    }

    for (nums, 0..) |num, idx| {
        const exist = first.get(num);
        const p = prev.get(num);
        const i = @as(i32, @intCast(idx));

        if (exist) |_| {
            const diff = i - p.?;
            best[idx] = @min(best[idx], diff);
            best[@as(usize, @intCast(p.?))] = @min(best[@as(usize, @intCast(p.?))], diff);
        } else {
            try first.put(num, i);
        }

        try prev.put(num, i);
    }

    // circular
    var it = first.iterator();

    while (it.next()) |entry| {
        const key = entry.key_ptr.*;
        const f = entry.value_ptr.*;
        const last = prev.get(key);

        if (last) |l| {
            if (l == f) {
                continue;
            }

            const circle = @mod(f - l + len, len);
            const fi = @as(usize, @intCast(f));
            const la = @as(usize, @intCast(l));

            best[fi] = @min(best[fi], circle);
            best[la] = @min(best[la], circle);
        }
    }

    for (queries, 0..) |q, i| {
        if (best[q] == 1000000007) {
            result[i] = -1;
        } else {
            result[i] = best[q];
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 3, 1, 4, 1, 3, 2 };
    const queries = [_]usize{ 0, 3, 5 };

    const expected = [_]i32{ 2, -1, 3 };
    const actual = try solution(allocator, &nums, &queries);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 2, 3, 4 };
    const queries = [_]usize{ 0, 1, 2, 3 };

    const expected = [_]i32{ -1, -1, -1, -1 };
    const actual = try solution(allocator, &nums, &queries);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
