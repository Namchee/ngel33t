const std = @import("std");

fn solution(moves: []const u8) i32 {
    var pos: i32 = 0;
    var rando: i32 = 0;

    for (moves) |move| {
        if (move == 'L') {
            pos -= 1;
        } else if (move == 'R') {
            pos += 1;
        } else {
            rando += 1;
        }
    }

    if (pos < 0) {
        pos -= rando;
    } else {
        pos += rando;
    }

    if (pos < 0) {
        pos *= -1;
    }

    return pos;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const moves = "L_RL__R";

    const expected = 3;
    const actual = solution(moves);

    try expect(expected, actual);
}

test "test case #2" {
    const moves = "_R__LL_";

    const expected = 5;
    const actual = solution(moves);

    try expect(expected, actual);
}

test "test case #3" {
    const moves = "_______";

    const expected = 7;
    const actual = solution(moves);

    try expect(expected, actual);
}
