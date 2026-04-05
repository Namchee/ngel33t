const std = @import("std");

fn solution(moves: []const u8) bool {
    var x: i32 = 0;
    var y: i32 = 0;

    for (moves) |move| {
        switch (move) {
            'U' => y += 1,
            'D' => y -= 1,
            'R' => x += 1,
            else => x -= 1,
        }
    }

    return x == 0 and y == 0;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const moves = "UD";

    const expected = true;
    const actual = solution(moves);

    try expect(expected, actual);
}

test "test case #2" {
    const moves = "LL";

    const expected = false;
    const actual = solution(moves);

    try expect(expected, actual);
}
