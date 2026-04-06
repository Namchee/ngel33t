const std = @import("std");

fn solution(commands: []const i32, obstacles: []const [2]i32) i32 {
    var best: i32 = 0;
    const walker = [_][2]i32{
        .{ 0, 1 },
        .{ 1, 0 },
        .{ 0, -1 },
        .{ -1, 0 },
    };

    var x: i32 = 0;
    var y: i32 = 0;
    var curr: usize = 0;

    for (commands) |command| {
        switch (command) {
            -1 => {
                curr = @mod(curr + 1, 4);
            },
            -2 => {
                curr = @mod(curr + 3, 4);
            },
            else => {
                for (0..@as(usize, @intCast(command))) |_| {
                    const newX = x + walker[curr][0];
                    const newY = y + walker[curr][1];

                    var flag = false;
                    for (obstacles) |o| {
                        if (o[0] == newX and o[1] == newY) {
                            flag = true;
                            break;
                        }
                    }

                    if (flag) {
                        break;
                    }

                    x = newX;
                    y = newY;

                    best = @max(best, (x * x) + (y * y));
                }
            },
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const commands = [_]i32{ 4, -1, 3 };
    const obstacles = [_][2]i32{};

    const expected = 25;
    const actual = solution(&commands, &obstacles);

    try expect(expected, actual);
}

test "test case #2" {
    const commands = [_]i32{ 4, -1, 4, -2, 4 };
    const obstacles = [_][2]i32{.{ 2, 4 }};

    const expected = 65;
    const actual = solution(&commands, &obstacles);

    try expect(expected, actual);
}

test "test case #3" {
    const commands = [_]i32{ 6, -1, -1, 6 };
    const obstacles = [_][2]i32{.{ 0, 0 }};

    const expected = 36;
    const actual = solution(&commands, &obstacles);

    try expect(expected, actual);
}
