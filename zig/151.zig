const std = @import("std");

fn solution(alloc: std.mem.Allocator, str: []const u8) ![]const u8 {
    var words = std.ArrayList([]const u8).init(alloc);
    defer {
        for (words.items) |word| {
            alloc.free(word);
        }
        words.deinit();
    }

    var temp = std.ArrayList(u8).init(alloc);
    defer temp.deinit();

    var wordCount: usize = 0;

    for (str) |el| {
        if (el != ' ') {
            try temp.append(el);
        } else if (temp.items.len > 0) {
            try words.append(try temp.toOwnedSlice());
            wordCount += 1;
            try temp.resize(0);
        }
    }

    if (temp.items.len > 0) {
        try words.append(try temp.toOwnedSlice());
        wordCount += 1;
    }

    var result = std.ArrayList(u8).init(alloc);
    defer result.deinit();

    // Append words in reverse order
    for (0..wordCount) |i| {
        if (i != 0) {
            try result.append(' ');
        }

        try result.appendSlice(words.items[wordCount - 1 - i]);
    }

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const str = "the sky is blue";

    const sol = try solution(std.testing.allocator, str);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, "blue is sky the", sol));
}

test "test case #2" {
    const str = "  hello world  ";

    const sol = try solution(std.testing.allocator, str);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, "world hello", sol));
}

test "test case #3" {
    const str = "a good   example";

    const sol = try solution(std.testing.allocator, str);
    defer std.testing.allocator.free(sol);

    try expect(std.mem.eql(u8, "example good a", sol));
}
