const std = @import("std");

fn solution(nums: []i32) i32 {
    var lo: i32 = 0;
    var hi: i32 = @intCast(nums.len);

    while (lo < hi) {
        const mid: i32 = lo + @divFloor((hi - lo), 2);

        var count: u32 = 0;
        for (nums) |el| {
            if (el > mid) {
                count += 1;
            }
        }

        if (count >= mid) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }

    return lo + @divFloor(hi - lo, 2);
}

fn solution_alt(nums: []i32) !i32 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var arr = std.ArrayList(i32).init(allocator);
    defer arr.deinit();

    const papers = nums.len;

    try arr.resize(papers + 1);
    for (0..papers + 1) |idx| {
        arr.items[idx] = 0;
    }

    for (nums) |el| {
        arr.items[@min(@as(usize, @intCast(el)), papers)] += 1;
    }

    var cumulative: i32 = 0;
    var idx = papers;

    while (idx >= 0) : (idx -= 1) {
        cumulative += arr.items[idx];
        if (cumulative >= idx) {
            return @intCast(idx);
        }
    }

    return 0;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 3, 0, 6, 1, 5 };

    const h = solution(&nums);

    try expect(h == 3);
}

test "test case #2" {
    var nums = [_]i32{ 1, 3, 1 };

    const h = solution(&nums);

    try expect(h == 1);
}
