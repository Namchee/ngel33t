const std = @import("std");

const MOD = 1000000007;

const Fancy = struct {
    sequence: std.ArrayList(i32),
    mult: i32,
    inc: i32,

    pub fn construct() Fancy {
        return Fancy{ .sequence = .empty, .mult = 1, .inc = 0 };
    }

    pub fn append(self: *Fancy, allocator: std.mem.Allocator, val: i32) void {
        const temp = (val - self.inc + MOD) % MOD;

        try self.sequence.append(allocator, @mod(temp * std.math.pow(i32, self.mult, MOD - 2)), MOD);
    }

    pub fn addAll(self: *Fancy, inc: i32) void {
        self.inc = @mod(self.inc + inc, MOD);
    }

    pub fn multAll(self: *Fancy, m: i32) void {
        self.mult = @mod(self.mult * m, MOD);
        self.inc = @mod(self.inc * m, MOD);
    }

    pub fn getIndex(self: *Fancy, idx: usize) i32 {
        if (idx >= self.sequence.items.len) {
            return -1;
        }

        var res = @mod(self.sequence[idx] * self.mult, MOD);
        res = @mod(res + self.inc, MOD);

        return res;
    }

    pub fn deinit(self: *Fancy, allocator: std.mem.Allocator) void {
        self.sequence.deinit(allocator);
    }
};
