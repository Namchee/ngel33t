const std = @import("std");

fn solution(alloc: std.mem.Allocator, str: []const u8, numRows: usize) ![]const u8 {
    var arr = std.ArrayList([]u8).init(alloc);
    defer {
        for (arr.items) |word| {
            alloc.free(word);
        }
        arr.deinit();
    }

    try arr.resize(numRows);

    for (arr.items) |*row| {
        row.* = try alloc.alloc(u8, str.len);
        @memset(row.*, ' ');
    }

    var flag: bool = true;
    var idx: usize = 0;

    var a: usize = 0;
    var b: usize = 0;

    while (idx < str.len) {
        arr.items[a][b] = str[idx];

        if (a == numRows - 1) {
            flag = false;
        }

        if (a == 0) {
            flag = true;
        }

        if (flag) {
            a += 1;
        } else {
            a -= 1;
            b += 1;
        }

        idx += 1;
    }

    var temp = std.ArrayList(u8).init(alloc);
    defer temp.deinit();

    for (arr.items) |*row| {
        for (row.*) |el| {
            if (el != ' ') {
                try temp.append(el);
            }
        }
    }

    return temp.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const str = "PAYPALISHIRING";
    const result = try solution(std.testing.allocator, str, 3);
    defer std.testing.allocator.free(result);

    try expect(std.mem.eql(u8, result, "PAHNAPLSIIGYIR"));
}

test "test case #2" {
    const str = "PAYPALISHIRING";
    const result = try solution(std.testing.allocator, str, 4);
    defer std.testing.allocator.free(result);

    try expect(std.mem.eql(u8, result, "PINALSIGYAHRPI"));
}

test "test case #3" {
    const str = "A";
    const result = try solution(std.testing.allocator, str, 1);
    defer std.testing.allocator.free(result);

    try expect(std.mem.eql(u8, result, "A"));
}
