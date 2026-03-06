const std = @import("std");

fn solution(s: []const u8) bool {
    if (s.len == 0) {
        return false;
    }

    var last = s[0];
    var curr: usize = 1;

    var bestOne: usize = 0;
    var bestZero: usize = 0;

    for (1..s.len) |idx| {
        const ch = s[idx];

        if (ch == last) {
            curr += 1;
        } else {
            if (last == '0') {
                bestZero = @max(bestZero, curr);
            } else {
                bestOne = @max(bestOne, curr);
            }

            last = ch;
            curr = 1;
        }
    }

    if (last == '0') {
        bestZero = @max(bestZero, curr);
    } else {
        bestOne = @max(bestOne, curr);
    }

    return bestOne > bestZero;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const input = "1101";
    const expected = true;

    try expect(solution(input), expected);
}

test "test case #2" {
    const input = "111000";
    const expected = false;

    try expect(solution(input), expected);
}
test "test case #3" {
    const input = "110100010";
    const expected = false;

    try expect(solution(input), expected);
}
