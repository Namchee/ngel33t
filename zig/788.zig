const std = @import("std");

fn solution(allocator: std.mem.Allocator, n: usize) !i32 {
    var result: i32 = 0;
    var table = try allocator.alloc(i32, n + 1);
    defer allocator.free(table);

    for (0..n + 1) |i| {
        if (i < 10) {
            if (i == 0 or i == 1 or i == 8) {
                table[i] = 1;
            } else if (i == 2 or i == 5 or i == 6 or i == 9) {
                table[i] = 2;
                result += 1;
            } else {
                table[i] = 0;
            }
        } else {
            const prefix = table[@divExact(i, 10)];
            const last = table[@mod(i, 10)];

            if (prefix == 1 and last == 1) {
                table[i] = 1;
            } else if (prefix == 2 and last == 2) {
                table[i] = 2;
                result += 1;
            } else {
                table[i] = 0;
            }
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const n = 10;

    const expected = 4;
    const actual = try solution(allocator, n);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const n = 1;

    const expected = 0;
    const actual = try solution(allocator, n);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;
    const n = 2;

    const expected = 1;
    const actual = try solution(allocator, n);

    try expect(expected, actual);
}
