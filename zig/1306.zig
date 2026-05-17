const std = @import("std");

fn solution(allocator: std.mem.Allocator, arr: []const i32, start: usize) !bool {
    var visited = try allocator.alloc(bool, arr.len);
    @memset(visited, false);
    visited[start] = true;

    var q: std.ArrayList(usize) = .empty;
    defer {
        allocator.free(visited);
        q.deinit(allocator);
    }

    try q.append(allocator, start);

    while (q.items.len > 0) {
        const curr = q.items[0];
        q.items = q.items[1..];

        if (arr[curr] == 0) {
            return true;
        }

        const left: i32 = @as(i32, @intCast(curr)) - arr[curr];
        if (left >= 0 and !visited[@as(usize, @intCast(left))]) {
            visited[@as(usize, @intCast(left))] = true;
            try q.append(allocator, @as(usize, @intCast(left)));
        }

        const right = curr + @as(usize, @intCast(arr[curr]));
        if (right < arr.len and !visited[right]) {
            visited[right] = true;
            try q.append(allocator, right);
        }
    }

    return false;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{ 4, 2, 3, 0, 3, 1, 2 };
    const start = 5;

    const expected = true;
    const actual = try solution(allocator, &arr, start);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{ 4, 2, 3, 0, 3, 1, 2 };
    const start = 0;

    const expected = true;
    const actual = try solution(allocator, &arr, start);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{ 3, 0, 2, 1, 2 };
    const start = 2;

    const expected = false;
    const actual = try solution(allocator, &arr, start);

    try expect(expected, actual);
}
