const std = @import("std");

const Robot = struct {
    position: i32,
    health: i32,
    direction: u8,
    idx: usize,
};

fn sortByPosition(_: void, a: Robot, b: Robot) bool {
    return a.position < b.position;
}

fn sortByIndex(_: void, a: Robot, b: Robot) bool {
    return a.idx < b.idx;
}

fn solution(allocator: std.mem.Allocator, positions: []const i32, healths: []const i32, directions: []const u8) ![]i32 {
    const len = positions.len;
    var robots = try allocator.alloc(Robot, len);
    defer allocator.free(robots);

    for (0..len) |i| {
        robots[i] = Robot{
            .position = positions[i],
            .health = healths[i],
            .direction = directions[i],
            .idx = i,
        };
    }

    std.mem.sort(Robot, robots, {}, sortByPosition);

    var stack: std.ArrayList(Robot) = .empty;
    defer stack.deinit(allocator);

    for (0..len) |i| {
        const curr = robots[i];
        var isDead = false;

        while (stack.items.len > 0) {
            const top = stack.getLast();

            if (top.direction == curr.direction or (top.direction == 'L' and curr.direction == 'R')) {
                break;
            }

            if (top.health == curr.health) {
                isDead = true;
                stack.items = stack.items[0 .. stack.items.len - 1];
                break;
            }

            if (top.health > curr.health) {
                isDead = true;
                stack.items[stack.items.len - 1].health -= 1;
                break;
            }

            stack.items = stack.items[0 .. stack.items.len - 1];
            robots[i].health -= 1;
        }

        if (!isDead) {
            try stack.append(allocator, curr);
        }
    }

    var result = try allocator.alloc(i32, stack.items.len);
    std.mem.sort(Robot, stack.items, {}, sortByIndex);

    for (0..stack.items.len) |i| {
        result[i] = stack.items[i].health;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const positions = [_]i32{ 5, 4, 3, 2, 1 };
    const healths = [_]i32{ 2, 17, 9, 15, 10 };
    const directions = "RRRRR";

    const expected = [_]i32{ 2, 17, 9, 15, 10 };
    const actual = try solution(allocator, &positions, &healths, directions);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const positions = [_]i32{ 3, 5, 2, 6 };
    const healths = [_]i32{ 10, 10, 15, 12 };
    const directions = "RLRL";

    const expected = [_]i32{14};
    const actual = try solution(allocator, &positions, &healths, directions);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const positions = [_]i32{ 1, 2, 5, 6 };
    const healths = [_]i32{ 10, 10, 11, 11 };
    const directions = "RLRL";

    const expected = [_]i32{};
    const actual = try solution(allocator, &positions, &healths, directions);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}
