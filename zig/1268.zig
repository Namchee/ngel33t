const std = @import("std");

const Trie = struct {
    children: [26]?*Trie,
    words: std.ArrayList([]const u8),

    fn create(allocator: std.mem.Allocator) !*Trie {
        const self = try allocator.create(Trie);

        inline for (0..26) |i| {
            self.children[i] = null;
        }

        self.words = .empty;
        return self;
    }

    fn deinit(self: *Trie, allocator: std.mem.Allocator) void {
        for (self.children) |child| {
            if (child) |c| {
                c.deinit(allocator);
            }
        }

        self.words.deinit(allocator);

        allocator.destroy(self);
    }

    fn insert(self: *Trie, allocator: std.mem.Allocator, word: []const u8) !void {
        var curr = self;
        for (word) |char| {
            const index = char - 'a';
            if (curr.children[index] == null) {
                curr.children[index] = try Trie.create(allocator);
            }
            curr = curr.children[index].?;

            try curr.words.append(allocator, word);
        }
    }
};

fn solution(allocator: std.mem.Allocator, products: [][]const u8, search: []const u8) ![][][]const u8 {
    std.mem.sort([]const u8, products, {}, struct {
        fn lessThan(_: void, a: []const u8, b: []const u8) bool {
            return std.mem.lessThan(u8, a, b);
        }
    }.lessThan);

    var trie = try Trie.create(allocator);
    defer trie.deinit(allocator);

    var result: std.ArrayList([][]const u8) = .empty;
    defer result.deinit(allocator);

    for (products) |p| {
        try trie.insert(allocator, p);
    }

    var curr: ?*Trie = trie;

    for (search) |s| {
        if (curr == null or curr.?.children[s - 'a'] == null) {
            try result.append(allocator, &[_][]const u8{});
            curr = null;
            continue;
        }

        const words = curr.?.children[s - 'a'].?.words;
        const limit = @min(3, words.items.len);

        const slice = try allocator.alloc([]const u8, limit);
        @memcpy(slice, words.items[0..limit]);

        try result.append(allocator, slice);
    }

    return result.toOwnedSlice(allocator);
}
