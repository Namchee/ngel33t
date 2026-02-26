const std = @import("std");

fn equal(a: []const u8, b: []const u8) bool {
    return std.mem.eql(u8, a, b);
}

fn solution(preorder: []const u8) bool {
    var it = std.mem.splitScalar(u8, preorder, ',');
    var slots: i32 = 1;

    while (it.next()) |ch| {
        slots -= 1;
        if (slots < 0) {
            return false;
        }

        if (!equal(ch, "#")) {
            slots += 2;
        }
    }

    return slots == 0;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = "9,3,4,#,#,1,#,#,2,#,6,#,#";
    const expected = true;

    try expect(solution(input) == expected);
}

test "test case #2" {
    const input = "1,#";
    const expected = false;

    try expect(solution(input) == expected);
}

test "test case #3" {
    const input = "9,#,#,1";
    const expected = false;

    try expect(solution(input) == expected);
}
