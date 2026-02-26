const std = @import("std");

fn isOne(s: []const u8) bool {
    if (s.len == 0) return false;
    for (s[0 .. s.len - 1]) |char| {
        if (char != '0') return false;
    }
    return s[s.len - 1] == '1';
}

fn addOne(alloc: std.mem.Allocator, list: *std.ArrayList(u8)) !void {
    var carry: usize = 1;
    var i: usize = list.items.len;

    while (i > 0) {
        i -= 1;
        if (carry == 1) {
            if (list.items[i] == '1') {
                list.items[i] = '0';
            } else {
                list.items[i] = '1';
                carry = 0;
            }
        }
    }

    if (carry == 1) {
        try list.insert(alloc, 0, '1');
    }
}

fn divideByTwo(list: *std.ArrayList(u8)) void {
    if (list.items.len <= 1) {
        list.items[0] = '0';
        return;
    }

    var i: usize = list.items.len - 1;
    while (i > 0) : (i -= 1) {
        list.items[i] = list.items[i - 1];
    }
    list.items[0] = '0';
}

fn solution(alloc: std.mem.Allocator, s: []const u8) !usize {
    var buffer: std.ArrayList(u8) = .empty;
    defer buffer.deinit(alloc);
    try buffer.appendSlice(alloc, s);

    var steps: usize = 0;

    while (!isOne(buffer.items)) {
        steps += 1;
        const last = buffer.items[buffer.items.len - 1];

        if (last == '1') {
            try addOne(alloc, &buffer);
        } else {
            divideByTwo(&buffer);
        }
    }

    return steps;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;
    const input = "1101";
    const expected = 6;

    const sol = try solution(alloc, input);

    try expect(sol == expected);
}

test "test case #2" {
    const alloc = std.testing.allocator;
    const input = "10";
    const expected = 1;

    const sol = try solution(alloc, input);

    try expect(sol == expected);
}

test "test case #3" {
    const alloc = std.testing.allocator;
    const input = "1";
    const expected = 0;

    const sol = try solution(alloc, input);

    try expect(sol == expected);
}
