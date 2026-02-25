const std = @import("std");

fn solution(arr: []i32, alloc: std.mem.Allocator) ![]i32 {
    std.mem.sort(i32, arr, {}, std.sort.asc(i32));

    var mp: std.AutoArrayHashMap(u32, std.ArrayList(i32)) = .init(alloc);
    defer {
        for (mp.values()) |*list| {
            list.deinit(alloc);
        }
        mp.deinit();
    }

    for (arr) |num| {
        const ct = @popCount(num);

        const gop = try mp.getOrPut(ct);
        if (!gop.found_existing) {
            gop.value_ptr.* = .empty;
        }
        try gop.value_ptr.append(alloc, num);
    }

    const keys = mp.keys();
    std.mem.sort(u32, keys, {}, std.sort.asc(u32));

    var result = try alloc.alloc(i32, arr.len);
    var idx: usize = 0;
    for (keys) |key| {
        const list = mp.get(key).?;
        for (list.items) |val| {
            result[idx] = val;
            idx += 1;
        }
    }

    return result;
}

const expect = std.testing.expectEqualSlices;

test "test case #1" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 0, 1, 2, 3, 4, 5, 6, 7, 8 };
    var expected = [_]i32{ 0, 1, 2, 4, 8, 3, 5, 6, 7 };

    const sol = try solution(&input, alloc);
    defer alloc.free(sol);

    try expect(i32, &expected, sol);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1 };
    var expected = [_]i32{ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 };

    const sol = try solution(&input, alloc);
    defer alloc.free(sol);

    try expect(i32, &expected, sol);
}
