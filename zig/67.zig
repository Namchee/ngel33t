const std = @import("std");

fn solution(alloc: std.mem.Allocator, a: []const u8, b: []const u8) ![]const u8 {
    var temp = std.ArrayList(u8).init(alloc);
    defer temp.deinit();

    var carry: bool = false;
    var c = a.len;
    var d = b.len;

    while (c > 0 or d > 0) {
        var sum: usize = 0;
        if (c > 0) {
            c -= 1;
            sum += if (a[c] == '1') 1 else 0;
        }

        if (d > 0) {
            d -= 1;
            sum += if (b[d] == '1') 1 else 0;
        }

        if (carry) {
            sum += 1;
        }

        carry = sum > 1;

        if (sum % 2 == 0) {
            try temp.insert(0, '0');
        } else {
            try temp.insert(0, '1');
        }
    }

    if (carry) {
        try temp.insert(0, '1');
    }

    return temp.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const a = "11";
    const b = "1";

    const sol = try solution(alloc, a, b);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, "100"));
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const a = "1010";
    const b = "1011";

    const sol = try solution(alloc, a, b);
    defer alloc.free(sol);

    try expect(std.mem.eql(u8, sol, "10101"));
}
