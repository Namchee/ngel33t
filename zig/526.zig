const std = @import("std");

fn permute(idx: usize, n: usize, freq: *[]bool) i32 {
    if (idx > n) {
        return 1;
    }

    var sum: i32 = 0;
    for (1..n + 1) |i| {
        if ((@mod(i, idx) == 0 or @mod(idx, i) == 0) and !freq.*[i]) {
            freq.*[i] = true;
            sum += permute(idx + 1, n, freq);
            freq.*[i] = false;
        }
    }

    return sum;
}

fn solution(allocator: std.mem.Allocator, n: usize) !i32 {
    var temp = try allocator.alloc(bool, n + 1);
    @memset(temp, false);
    defer allocator.free(temp);

    return permute(1, n, &temp);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const n = 2;

    const expected = 2;
    const actual = try solution(allocator, n);

    try expect(expected, actual);
}
