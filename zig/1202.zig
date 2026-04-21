const std = @import("std");

const UnionFind = struct {
    parent: []usize,

    pub fn new(allocator: std.mem.Allocator, len: usize) !UnionFind {
        var parent = try allocator.alloc(usize, len);
        for (0..len) |i| {
            parent[i] = i;
        }

        return UnionFind{
            .parent = parent,
        };
    }

    pub fn deinit(self: *UnionFind, allocator: std.mem.Allocator) void {
        allocator.free(self.parent);
    }

    pub fn find(self: *UnionFind, x: usize) usize {
        if (self.parent[x] != x) {
            self.parent[x] = self.find(self.parent[x]);
        }

        return self.parent[x];
    }

    pub fn unite(self: *UnionFind, a: usize, b: usize) void {
        const rootA = self.find(a);
        const rootB = self.find(b);

        if (rootA != rootB) {
            self.parent[rootB] = rootA;
        }
    }
};

fn solution(allocator: std.mem.Allocator, s: []const u8, pairs: []const [2]usize) ![]const u8 {
    const n = s.len;
    var uf = try UnionFind.new(allocator, n);

    for (pairs) |pair| {
        uf.unite(pair[0], pair[1]);
    }

    var mp: std.AutoHashMap(usize, std.ArrayList(u8)) = .init(allocator);
    defer {
        var it = mp.iterator();
        while (it.next()) |entry| {
            entry.value_ptr.deinit(allocator);
        }

        mp.deinit();
        uf.deinit(allocator);
    }

    for (0..n) |i| {
        const ptr = try mp.getOrPut(uf.find(i));
        if (!ptr.found_existing) {
            ptr.value_ptr.* = .empty;
        }

        try ptr.value_ptr.append(allocator, s[i]);
    }

    var it = mp.iterator();
    while (it.next()) |entry| {
        std.mem.sort(u8, entry.value_ptr.items, {}, std.sort.asc(u8));
    }

    var container = try allocator.alloc(u8, n);
    for (0..n) |i| {
        const ptr = mp.getPtr(uf.find(i));
        if (ptr) |p| {
            container[i] = p.items[0];
            p.items = p.items[1..];
        }
    }

    return container;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s = "dcab";
    const pairs = [_][2]usize{
        .{ 0, 3 },
        .{ 1, 2 },
    };

    const expected = "bacd";
    const actual = try solution(allocator, s, &pairs);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s = "dcab";
    const pairs = [_][2]usize{
        .{ 0, 3 },
        .{ 1, 2 },
        .{ 0, 2 },
    };

    const expected = "abcd";
    const actual = try solution(allocator, s, &pairs);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const s = "cba";
    const pairs = [_][2]usize{
        .{ 0, 1 },
        .{ 1, 2 },
    };

    const expected = "abc";
    const actual = try solution(allocator, s, &pairs);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
