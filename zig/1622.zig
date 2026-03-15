const std = @import("std");

const MOD = 1000000007;

const FancyValue = struct {
    val: i32,
    idx: usize,
};

const FancyOperation = struct {
    mult: bool,
    val: i32,
};

const Fancy = struct {
    sequence: std.ArrayList(FancyValue),
    operations: std.ArrayList(FancyOperation),

    pub fn construct() Fancy {
        return Fancy{ .sequence = .empty, .operations = .empty };
    }

    pub fn append(self: *Fancy, allocator: std.mem.Allocator, val: i32) void {
        try self.sequence.append(allocator, FancyValue{ .val = val, .idx = self.operations.items.len });
    }

    pub fn addAll(self: *Fancy, allocator: std.mem.Allocator, inc: i32) void {
        try self.operations.append(allocator, FancyOperation{ .mult = false, .val = inc });
    }

    pub fn multAll(self: *Fancy, allocator: std.mem.Allocator, m: i32) void {
        try self.operations.append(allocator, FancyOperation{ .mult = false, .val = m });
    }

    pub fn getIndex(self: *Fancy, idx: usize) i32 {
        if (idx >= self.sequence.items.len) {
            return -1;
        }

        for (self.sequence.items[idx].idx..self.operations.items.len) |i| {
            if (self.operations.items[i].mult) {
                self.sequence.items[idx].val = @mod(self.sequence.items[idx].val * self.operations.items[i].val, MOD);
            } else {
                self.sequence.items[idx].val = @mod(self.sequence.items[idx].val + self.operations.items[i].val, MOD);
            }
        }

        self.sequence.items[idx].idx = self.operations.items.len;

        return self.sequence.items[idx].val;
    }
};
