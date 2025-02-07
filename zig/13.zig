const std = @import("std");

const expect = std.testing.expect;

const Entry = struct { []const u8, i32 };

fn solution(str: []const u8) i32 {
    const dict = [_]Entry{
        .{ "I", 1 },
        .{ "IV", 4 },
        .{ "V", 5 },
        .{ "IX", 9 },
        .{ "X", 10 },
        .{ "XL", 40 },
        .{ "L", 50 },
        .{ "XC", 90 },
        .{ "C", 100 },
        .{ "CD", 400 },
        .{ "D", 500 },
        .{ "CM", 900 },
        .{ "M", 1000 },
    };

    var idx: usize = 0;
    var result: i32 = 0;

    while (idx < str.len) : (idx += 1) {
        var runner: usize = dict.len;

        while (runner > 0) {
            runner -= 1;

            const prefix = dict[runner];

            if (prefix[0].len == 2 and idx < str.len - 1 and prefix[0][0] == str[idx] and prefix[0][1] == str[idx + 1]) {
                result += prefix[1];
                idx += 1;
                break;
            }

            if (prefix[0].len == 1 and prefix[0][0] == str[idx]) {
                result += prefix[1];
                break;
            }
        }
    }

    return result;
}

test "test case #1" {
    const str = "III";

    const sol = solution(str);

    try expect(sol == 3);
}

test "test case #2" {
    const str = "LVIII";

    const sol = solution(str);

    try expect(sol == 58);
}

test "test case #3" {
    const str = "MCMXCIV";

    const sol = solution(str);

    try expect(sol == 1994);
}
