const std = @import("std");

const Entry = struct { x: i32, y: i32, z: i32 };

fn solution(alloc: std.mem.Allocator, nums: []i32) ![]Entry {
    std.mem.sort(i32, nums, {}, comptime std.sort.asc(i32));

    var result = std.ArrayList(Entry).init(alloc);
    defer result.deinit();

    var a: usize = 0;

    while (a < nums.len - 2) {
        var b = a + 1;
        var c = nums.len - 1;

        while (b < c) {
            const total = nums[a] + nums[b] + nums[c];

            if (total < 0) {
                b += 1;
            } else if (total > 0) {
                c -= 1;
            } else {
                try result.append(Entry{
                    .x = nums[a],
                    .y = nums[b],
                    .z = nums[c],
                });

                b += 1;

                while (b < nums.len and nums[b] == nums[b - 1]) {
                    b += 1;
                }
            }
        }

        a += 1;

        while (a < nums.len and nums[a] == nums[a - 1]) {
            a += 1;
        }
    }

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ -1, 0, 1, 2, -1, -4 };

    const sol = try solution(std.testing.allocator, &nums);
    defer std.testing.allocator.free(sol);

    try expect(sol.len == 2);

    const first = sol[0];
    const second = sol[1];

    try expect(first.x == -1);
    try expect(first.y == -1);
    try expect(first.z == 2);

    try expect(second.x == -1);
    try expect(second.y == 0);
    try expect(second.z == 1);
}

test "test case #2" {
    var nums = [_]i32{ -1, 0, 1, 2, -1, -4 };

    const sol = try solution(std.testing.allocator, &nums);
    defer std.testing.allocator.free(sol);

    try expect(sol.len == 2);

    const first = sol[0];
    const second = sol[1];

    try expect(first.x == -1);
    try expect(first.y == -1);
    try expect(first.z == 2);

    try expect(second.x == -1);
    try expect(second.y == 0);
    try expect(second.z == 1);
}

test "test case #3" {
    var nums = [_]i32{ 0, 0, 0 };

    const sol = try solution(std.testing.allocator, &nums);
    defer std.testing.allocator.free(sol);

    try expect(sol.len == 1);

    const first = sol[0];

    try expect(first.x == 0);
    try expect(first.y == 0);
    try expect(first.z == 0);
}
