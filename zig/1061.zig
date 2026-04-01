const std = @import("std");

const DisjointSetUnion = struct {
    container: std.AutoHashMap(u8, u8),

    pub fn init(allocator: std.mem.Allocator) DisjointSetUnion {
        return DisjointSetUnion{
            .container = .init(allocator),
        };
    }

    pub fn deinit(self: *DisjointSetUnion) void {
        self.container.deinit();
    }

    pub fn register(self: *DisjointSetUnion, ch: u8) !void {
        try self.container.put(ch, ch);
    }

    pub fn findParent(self: *DisjointSetUnion, ch: u8) !?u8 {
        const curr = self.container.get(ch);
        if (curr == null) {
            try self.container.put(ch, ch);

            return ch;
        }

        if (curr.? == ch) {
            return curr;
        }

        const parent = try self.findParent(curr.?);

        if (parent) |p| {
            try self.container.put(curr.?, p);
        }

        return self.container.get(curr.?);
    }

    pub fn combine(self: *DisjointSetUnion, a: u8, b: u8) !void {
        const parentA = try self.findParent(a);
        const parentB = try self.findParent(b);

        if (parentA.? != parentB.?) {
            if (parentA.? < parentB.?) {
                try self.container.put(parentB.?, parentA.?);
            } else {
                try self.container.put(parentA.?, parentB.?);
            }
        }
    }
};

fn solution(allocator: std.mem.Allocator, s1: []const u8, s2: []const u8, baseStr: []const u8) ![]const u8 {
    var mp = DisjointSetUnion.init(allocator);
    defer mp.deinit();

    for (s1) |ch| {
        try mp.register(ch);
    }

    for (s2) |ch| {
        try mp.register(ch);
    }

    for (0..s1.len) |i| {
        try mp.combine(s1[i], s2[i]);
    }

    var result = try allocator.alloc(u8, baseStr.len);

    for (baseStr, 0..) |ch, i| {
        const parent = try mp.findParent(ch);

        if (parent) |p| {
            result[i] = p;
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s1 = "parker";
    const s2 = "morris";
    const baseStr = "parser";

    const expected = "makkek";
    const actual = try solution(allocator, s1, s2, baseStr);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s1 = "hello";
    const s2 = "world";
    const baseStr = "hold";

    const expected = "hdld";
    const actual = try solution(allocator, s1, s2, baseStr);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #" {
    const allocator = std.testing.allocator;

    const s1 = "leetcode";
    const s2 = "programs";
    const baseStr = "sourcecode";

    const expected = "aauaaaaada";
    const actual = try solution(allocator, s1, s2, baseStr);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}
