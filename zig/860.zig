const std = @import("std");

fn solution(bills: []const i32) bool {
    var fives: i32 = 0;
    var tens: i32 = 0;
    var twenties: i32 = 0;

    for (bills) |bill| {
        switch (bill) {
            5 => {
                fives += 1;
            },
            10 => {
                tens += 1;
            },
            else => {
                twenties += 1;
            },
        }

        var ret = bill - 5;

        while (ret >= 20 and twenties > 0) {
            twenties -= 1;
            ret -= 20;
        }

        while (ret >= 10 and tens > 0) {
            tens -= 1;
            ret -= 10;
        }

        while (ret >= 5 and fives > 0) {
            fives -= 1;
            ret -= 5;
        }

        if (ret > 0) {
            return false;
        }
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const bills = [_]i32{ 5, 5, 5, 10, 20 };

    const expected = true;
    const actual = solution(&bills);

    try expect(expected, actual);
}

test "test case #2" {
    const bills = [_]i32{ 5, 5, 10, 10, 20 };

    const expected = false;
    const actual = solution(&bills);

    try expect(expected, actual);
}
