const std = @import("std");

const MinStack = struct {
    stk: std.ArrayList(i32),
    mins: std.ArrayList(i32),

    pub fn init(alloc: std.mem.Allocator) MinStack {
        return MinStack{
            .stk = std.ArrayList(i32).init(alloc),
            .mins = std.ArrayList(i32).init(alloc),
        };
    }

    pub fn deinit(self: *MinStack) void {
        self.stk.deinit();
        self.mins.deinit();
    }

    pub fn min(self: *MinStack) i32 {
        if (self.mins.items.len == 0) {
            return std.math.maxInt(i32);
        }

        return self.mins.getLast();
    }

    pub fn push(self: *MinStack, val: i32) !void {
        if (self.min() >= val) {
            try self.mins.append(val);
        }

        try self.stk.append(val);
    }

    pub fn pop(self: *MinStack) i32 {
        if (self.stk.items.len == 0) {
            return -1;
        }

        const val: i32 = self.stk.pop();
        if (val == self.min()) {
            _ = self.mins.pop();
        }

        return val;
    }
};

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var min_stack = MinStack.init(alloc);
    defer min_stack.deinit();

    try min_stack.push(2);
    try expect(min_stack.min() == 2);

    try min_stack.push(3);
    try expect(min_stack.min() == 2);

    try min_stack.push(1);
    try expect(min_stack.min() == 1);

    _ = min_stack.pop();
    try expect(min_stack.min() == 2);
}
