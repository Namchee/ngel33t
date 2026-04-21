const std = @import("std");

const UnionFind = struct {
    parent: []usize,
    rank: []usize,

    fn new(allocator: std.mem.Allocator, len: usize) !UnionFind {
        var parent = try allocator.alloc(usize, len);
        var rank = try allocator.alloc(usize, len);

        for (0..len) |i| {
            parent[i] = i;
            rank[i] = 1;
        }

        return UnionFind{
            .parent = parent,
            .rank = rank,
        };
    }

    fn deinit(self: *UnionFind, allocator: std.mem.Allocator) void {
        allocator.free(self.parent);
        allocator.free(self.rank);
    }

    fn find(self: *UnionFind, x: usize) usize {
        if (self.parent[x] != x) {
            self.parent[x] = self.find(self.parent[x]);
        }

        return self.parent[x];
    }

    fn unite(self: *UnionFind, a: usize, b: usize) void {
        const rootA = self.find(a);
        const rootB = self.find(b);

        if (rootA != rootB) {
            if (self.rank[rootA] > self.rank[rootB]) {
                self.parent[rootB] = rootA;
            } else if (self.rank[rootA] < self.rank[rootB]) {
                self.parent[rootA] = rootB;
            } else {
                self.parent[rootB] = rootA;
                self.rank[rootA] += 1;
            }
        }
    }
};

fn solution(allocator: std.mem.Allocator, source: []const usize, target: []const usize, allowedSwaps: []const [2]usize) !usize {
    const n = source.len;
    var uf = try UnionFind.new(allocator, n);

    for (allowedSwaps) |swap| {
        uf.unite(swap[0], swap[1]);
    }

    var mp: std.AutoHashMap(usize, std.AutoHashMap(usize, usize)) = .init(allocator);
    defer {
        uf.deinit(allocator);

        var it = mp.iterator();
        while (it.next()) |entry| {
            entry.value_ptr.*.deinit();
        }

        mp.deinit();
    }

    for (0..n) |i| {
        const root = uf.find(i);

        const gop = try mp.getOrPut(root);
        if (!gop.found_existing) {
            gop.value_ptr.* = std.AutoHashMap(usize, usize).init(allocator);
        }

        const freq_map = gop.value_ptr;
        const entry = try freq_map.getOrPut(source[i]);
        if (!entry.found_existing) {
            entry.value_ptr.* = 0;
        }

        entry.value_ptr.* += 1;
    }

    var hamming_dist: usize = 0;
    for (0..n) |i| {
        const root = uf.find(i);
        var freq_map = mp.getPtr(root).?;

        if (freq_map.getPtr(target[i])) |count_ptr| {
            if (count_ptr.* > 0) {
                count_ptr.* -= 1;
            } else {
                hamming_dist += 1;
            }
        } else {
            hamming_dist += 1;
        }
    }

    return hamming_dist;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const source = [_]usize{ 1, 2, 3, 4 };
    const target = [_]usize{ 2, 1, 4, 5 };
    const allowedSwaps = [_][2]usize{
        .{ 0, 1 },
        .{ 2, 3 },
    };

    const expected = 1;
    const actual = try solution(allocator, &source, &target, &allowedSwaps);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const source = [_]usize{ 1, 2, 3, 4 };
    const target = [_]usize{ 1, 3, 2, 4 };
    const allowedSwaps = [_][2]usize{};

    const expected = 2;
    const actual = try solution(allocator, &source, &target, &allowedSwaps);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const source = [_]usize{ 5, 1, 2, 4, 3 };
    const target = [_]usize{ 1, 5, 4, 2, 3 };
    const allowedSwaps = [_][2]usize{
        .{ 0, 4 },
        .{ 4, 2 },
        .{ 1, 3 },
        .{ 1, 4 },
    };

    const expected = 0;
    const actual = try solution(allocator, &source, &target, &allowedSwaps);

    try expect(expected, actual);
}
