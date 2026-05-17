const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8, minJ: usize, maxJ: usize) !bool {
    const n = s.len;
    var pre: i32 = 0;

    var table = try allocator.alloc(bool, n);
    defer allocator.free(table);
    table[0] = true;

    for (1..n) |i| {
        if (i >= minJ and table[i - minJ]) {
            pre += 1;
        }

        if (i > maxJ and table[i - maxJ - 1]) {
            pre -= 1;
        }

        if (pre > 0 and s[i] == '0') {
            table[i] = true;
        } else {
            table[i] = false;
        }
    }

    return table[n - 1];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s = "011010";
    const minJ = 2;
    const maxJ = 3;

    const expected = true;
    const actual = try solution(allocator, s, minJ, maxJ);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s = "01101110";
    const minJ = 2;
    const maxJ = 3;

    const expected = false;
    const actual = try solution(allocator, s, minJ, maxJ);

    try expect(expected, actual);
}
