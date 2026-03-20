const std = @import("std");

fn sieve(allocator: std.mem.Allocator, n: usize) ![]i32 {
    var result: std.ArrayList(i32) = .empty;
    defer result.deinit(allocator);
    if (n < 2) {
        return result.toOwnedSlice(allocator);
    }

    var isPrimes = try allocator.alloc(bool, n + 1);
    defer allocator.free(isPrimes);
    @memset(isPrimes, true);

    var p: usize = 2;

    while (p * p <= n) : (p += 1) {
        if (isPrimes[p]) {
            var i = p * p;
            while (i <= n) : (i += p) {
                isPrimes[i] = false;
            }
        }
    }

    for (2..n + 1) |i| {
        if (isPrimes[i]) {
            try result.append(allocator, @as(i32, @intCast(i)));
        }
    }

    return result.toOwnedSlice(allocator);
}

fn solution(allocator: std.mem.Allocator, nums: []const i32) !i64 {
    const primes = try sieve(allocator, nums.len);
    defer allocator.free(primes);

    var idx: usize = 0;

    var a: i64 = 0;
    var b: i64 = 0;

    for (0..nums.len) |i| {
        if (idx < primes.len and primes[idx] == i) {
            a += @as(i64, @intCast(nums[i]));
            idx += 1;
        } else {
            b += @as(i64, @intCast(nums[i]));
        }
    }

    var diff = a - b;
    if (diff < 0) {
        diff *= -1;
    }

    return diff;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 2, 3, 4 };

    const expected = 1;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ -1, 5, 7, 0 };

    const expected = 3;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}
