const std = @import("std");

const Trie = struct {
    alloc: std.mem.Allocator,
    children: [26]?*Trie,
    is_word: bool,

    pub fn init(alloc: std.mem.Allocator) !*Trie {
        var trie = try alloc.create(Trie);
        for (0..26) |i| {
            trie.children[i] = null;
        }
        trie.is_word = false;
        trie.alloc = alloc;

        return trie;
    }

    pub fn insert(self: *Trie, word: []const u8) !void {
        var curr = self;

        for (word) |c| {
            if (curr.children[c - 'a'] == null) {
                curr.children[c - 'a'] = try Trie.init(self.alloc);
            }

            curr = curr.children[c - 'a'].?;
        }

        curr.is_word = true;
    }

    pub fn search(self: *Trie, word: []const u8) bool {
        var curr = self;

        for (word) |c| {
            if (curr.children[c - 'a'] == null) {
                return false;
            }

            curr = curr.children[c - 'a'].?;
        }

        return curr.is_word;
    }

    pub fn starts_with(self: *Trie, word: []const u8) bool {
        var curr = self;

        for (word) |c| {
            if (curr.children[c - 'a'] == null) {
                return false;
            }

            curr = curr.children[c - 'a'].?;
        }

        return true;
    }

    pub fn destroy(self: *Trie) void {
        defer self.alloc.destroy(self);

        for (self.children) |c| {
            if (c != null) {
                c.?.destroy();
            }
        }
    }
};

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var trie = try Trie.init(alloc);
    defer trie.destroy();

    try trie.insert("apple");

    const apple = trie.search("apple");

    try expect(apple);

    const wombat = trie.search("wombat");
    try expect(!wombat);

    const appl = trie.search("appl");
    try expect(!appl);

    const starts_appl = trie.starts_with("appl");
    try expect(starts_appl);
}
