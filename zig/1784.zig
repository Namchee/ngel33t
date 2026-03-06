const std = @import("std");

fn solution(str: []const u8) bool {
    var flag = true;

    for (str) |ch| {
        if (ch == '1') {
            if (!flag) {
                return false;
            }
        } else {
            flag = false;
        }
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const str = "1001";
    const expected = false;

    try expect(solution(str), expected);
}

test "test case #2" {
    const str = "110";
    const expected = true;

    try expect(solution(str), expected);
}
