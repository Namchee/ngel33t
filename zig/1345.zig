const std = @import("std");

fn solution(allocator: std.mem.Allocator, arr: []const i32) !i32 {
    const n = arr.len;

    var steps = try allocator.alloc(i32, n);
    @memset(steps, -1);
    steps[0] = 0;

    var adj: std.AutoHashMap(i32, std.ArrayList(usize)) = .init(allocator);
    for (arr, 0..) |num, i| {
        var ptr = try adj.getOrPut(num);
        if (!ptr.found_existing) {
            ptr.value_ptr.* = .empty;
        }

        try ptr.value_ptr.append(allocator, i);
    }

    var q: std.ArrayList(usize) = .empty;
    defer {
        var it = adj.iterator();
        while (it.next()) |entry| {
            entry.value_ptr.deinit(allocator);
        }
        adj.deinit();
        allocator.free(steps);
        q.deinit(allocator);
    }

    try q.append(allocator, 0);

    while (q.items.len > 0) {
        const curr = q.orderedRemove(0);

        if (curr == n - 1) {
            return steps[curr];
        }

        // back
        if (curr > 0 and steps[curr - 1] == -1) {
            steps[curr - 1] = steps[curr] + 1;
            try q.append(allocator, curr - 1);
        }

        // front
        if (curr + 1 < n and steps[curr + 1] == -1) {
            steps[curr + 1] = steps[curr] + 1;
            try q.append(allocator, curr + 1);
        }

        // power jump
        const neighbor = adj.getPtr(arr[curr]);
        if (neighbor) |ne| {
            for (ne.items) |next| {
                if (steps[next] == -1) {
                    steps[next] = steps[curr] + 1;
                    try q.append(allocator, next);
                }
            }

            ne.deinit(allocator);
            _ = adj.remove(arr[curr]);
        }
    }

    return -1;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{ 100, -23, -23, 404, 100, 23, 23, 23, 3, 404 };

    const expected = 3;
    const actual = try solution(allocator, &arr);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{7};

    const expected = 0;
    const actual = try solution(allocator, &arr);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const arr = [_]i32{ 7, 6, 9, 6, 9, 6, 9, 7 };

    const expected = 1;
    const actual = try solution(allocator, &arr);

    try expect(expected, actual);
}
