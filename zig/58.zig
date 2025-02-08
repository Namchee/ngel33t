const std = @import("std");

fn solution(str: []const u8) usize {
    var back = str.len;
    var len: usize = 0;

    while (back > 0) {
        back -= 1;

        if (str[back] != ' ') {
            break;
        }
    }

    while (back > 0) {
        if (str[back] == ' ') {
            break;
        } else {
            len += 1;
            back -= 1;
        }
    }

    return len;
}

const expect = std.testing.expect;

test "test case #1" {
    const str = "Hello World";
    const result = solution(str);

    try expect(result == 5);
}

test "test case #2" {
    const str = "   fly me   to   the moon  ";
    const result = solution(str);

    try expect(result == 4);
}

test "test case #3" {
    const str = "luffy is still joyboy";
    const result = solution(str);

    try expect(result == 6);
}
