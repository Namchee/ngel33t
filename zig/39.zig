const std = @import("std");

fn backtrack(candidates: []i32, index: usize, rem: i32, temp: *std.ArrayList(i32), result: *std.ArrayList([]i32)) !void {
    if (rem < 0) {
        return;
    }

    if (rem == 0) {
        const combi = try result.allocator.alloc(i32, temp.items.len);
        @memcpy(combi, temp.items);

        try result.append(combi);
        return;
    }

    for (index..candidates.len) |idx| {
        if (candidates[idx] > rem) {
            break;
        }

        try temp.append(candidates[idx]);
        try backtrack(candidates, idx, rem - candidates[idx], temp, result);
        _ = temp.pop();
    }
}

fn solution(alloc: std.mem.Allocator, candidates: []i32, target: i32) ![][]i32 {
    std.mem.sort(i32, candidates, {}, comptime std.sort.asc(i32));

    var result = std.ArrayList([]i32).init(alloc);
    defer result.deinit();

    var temp = std.ArrayList(i32).init(alloc);
    defer temp.deinit();

    try backtrack(candidates, 0, target, &temp, &result);

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 2, 3, 6, 7 };
    const target = 7;

    const sol = try solution(alloc, &input, target);

    defer {
        for (sol) |item| {
            alloc.free(item);
        }

        alloc.free(sol);
    }

    var e1 = [_]i32{ 2, 2, 3 };
    var e2 = [_]i32{7};

    try expect(sol.len == 2);
    try expect(std.mem.eql(i32, sol[0], &e1));
    try expect(std.mem.eql(i32, sol[1], &e2));
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var input = [_]i32{ 2, 3, 5 };
    const target = 8;

    const sol = try solution(alloc, &input, target);

    defer {
        for (sol) |item| {
            alloc.free(item);
        }

        alloc.free(sol);
    }

    var e1 = [_]i32{ 2, 2, 2, 2 };
    var e2 = [_]i32{ 2, 3, 3 };
    var e3 = [_]i32{ 3, 5 };

    try expect(sol.len == 3);
    try expect(std.mem.eql(i32, sol[0], &e1));
    try expect(std.mem.eql(i32, sol[1], &e2));
    try expect(std.mem.eql(i32, sol[2], &e3));
}

test "test case #3" {
    const alloc = std.testing.allocator;

    var input = [_]i32{2};
    const target = 1;

    const sol = try solution(alloc, &input, target);

    defer {
        for (sol) |item| {
            alloc.free(item);
        }

        alloc.free(sol);
    }

    try expect(sol.len == 0);
}
