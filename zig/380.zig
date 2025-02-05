const std = @import("std");

const RandomizedSet = struct {
    arr: std.ArrayList(i32),
    mp: std.AutoHashMap(i32, usize),

    pub fn init(alloc: std.mem.Allocator) RandomizedSet {
        return RandomizedSet{
            .arr = std.ArrayList(i32).init(alloc),
            .mp = std.AutoHashMap(i32, usize).init(alloc),
        };
    }

    pub fn deinit(self: *RandomizedSet) void {
        self.arr.deinit();
        self.mp.deinit();
    }

    pub fn insert(self: *RandomizedSet, val: i32) !bool {
        if (self.mp.contains(val)) {
            return false;
        }

        const idx = self.arr.items.len;
        try self.arr.append(val);
        try self.mp.put(val, idx);

        return true;
    }

    pub fn remove(self: *RandomizedSet, val: i32) !bool {
        if (!self.mp.contains(val)) {
            return false;
        }

        const idx = self.mp.get(val).?;
        const temp = self.arr.getLast();
        self.arr.items[idx] = temp;
        try self.arr.resize(self.arr.items.len - 1);

        _ = self.mp.remove(val);
        try self.mp.put(temp, idx);

        return true;
    }

    pub fn getRandom(self: *RandomizedSet) !i32 {
        var prng = std.rand.DefaultPrng.init(@as(u64, std.time.timestamp()));
        const rng = prng.random();

        const idx = rng.intRangeAtMost(usize, 0, self.arr.items.len - 1);

        return self.arr.items[idx];
    }
};

const expect = std.testing.expect;

test "test case #1" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    var set = RandomizedSet.init(alloc);
    defer set.deinit();

    const op1 = try set.insert(1);

    try expect(op1 == true);

    const op2 = try set.remove(2);

    try expect(op2 == false);

    const op3 = try set.insert(2);

    try expect(op3 == true);
}
