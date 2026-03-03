const std = @import("std");

fn solution(allocator: std.mem.Allocator, n: usize, k: usize) !u8 {
    var table = try allocator.alloc([]u8, n);
    table[0] = try allocator.alloc(u8, 1);
    table[0][0] = '0';

    defer {
        for (0..n) |idx| {
            allocator.free(table[idx]);
        }

        allocator.free(table);
    }

    for (1..n) |idx| {
        const last = table[idx - 1];
        var newString: std.ArrayList(u8) = .empty;
        defer newString.deinit(allocator);

        for (last) |ch| {
            try newString.append(allocator, ch);
        }

        try newString.append(allocator, '1');

        // invert
        var inverted: std.ArrayList(u8) = .empty;
        defer inverted.deinit(allocator);

        for (last) |ch| {
            if (ch == '1') {
                try inverted.append(allocator, '0');
            } else {
                try inverted.append(allocator, '1');
            }
        }

        // reverse
        for (0..inverted.items.len / 2) |i| {
            const temp = inverted.items[i];
            inverted.items[i] = inverted.items[inverted.items.len - 1 - i];
            inverted.items[inverted.items.len - 1 - i] = temp;
        }

        for (inverted.items) |ch| {
            try newString.append(allocator, ch);
        }

        table[idx] = try newString.toOwnedSlice(allocator);
    }

    return table[n - 1][k - 1];
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const n = 3;
    const k = 1;
    const expected = '0';

    const sol = try solution(allocator, n, k);

    try expect(sol == expected);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const n = 4;
    const k = 11;
    const expected = '1';

    const sol = try solution(allocator, n, k);

    try expect(sol == expected);
}
