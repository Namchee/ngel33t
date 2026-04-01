const std = @import("std");

fn solution(allocator: std.mem.Allocator, asteroids: []const i32) ![]i32 {
    var stack: std.ArrayList(i32) = .empty;
    defer stack.deinit(allocator);

    for (asteroids) |asteroid| {
        if (stack.items.len == 0) {
            try stack.append(allocator, asteroid);
            continue;
        }

        var isDead = false;

        while (stack.items.len > 0) {
            var curr = asteroid;
            var top = stack.getLast();

            if ((top > 0 and curr > 0) or (top < 0 and curr < 0) or (top < 0 and curr > 0)) {
                break;
            }

            if (curr < 0) {
                curr *= -1;
            }

            if (top < 0) {
                top *= -1;
            }

            if (curr == top) {
                isDead = true;
                stack.items = stack.items[0 .. stack.items.len - 1];
                break;
            }

            if (curr < top) {
                isDead = true;
                break;
            }

            stack.items = stack.items[0 .. stack.items.len - 1];
        }

        if (!isDead) {
            try stack.append(allocator, asteroid);
        }
    }

    return stack.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const asteroids = [_]i32{ 5, 10, -5 };

    const expected = [_]i32{ 5, 10 };
    const actual = try solution(allocator, &asteroids);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const asteroids = [_]i32{ 8, -8 };

    const expected = [_]i32{};
    const actual = try solution(allocator, &asteroids);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const asteroids = [_]i32{ 3, 5, -6, 2, -1, 4 };

    const expected = [_]i32{ -6, 2, 4 };
    const actual = try solution(allocator, &asteroids);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
