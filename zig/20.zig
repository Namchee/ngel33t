const std = @import("std");

fn solution(alloc: std.mem.Allocator, set: []const u8) !bool {
    var stk = std.ArrayList(u8).init(alloc);
    defer stk.deinit();

    for (set) |c| {
        switch (c) {
            '(' => {
                try stk.append('(');
            },
            ')' => {
                if (stk.getLast() != '(') {
                    return false;
                }

                _ = stk.pop();
            },
            '{' => {
                try stk.append('{');
            },
            '}' => {
                if (stk.getLast() != '{') {
                    return false;
                }

                _ = stk.pop();
            },
            '[' => {
                try stk.append('[');
            },
            else => {
                if (stk.getLast() != '[') {
                    return false;
                }

                _ = stk.pop();
            },
        }
    }

    return stk.items.len == 0;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = "()";

    const sol = try solution(std.testing.allocator, input);

    try expect(sol);
}

test "test case #2" {
    const input = "()[]{}";

    const sol = try solution(std.testing.allocator, input);

    try expect(sol);
}

test "test case #3" {
    const input = "([])";

    const sol = try solution(std.testing.allocator, input);

    try expect(sol);
}
