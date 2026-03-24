const std = @import("std");

fn sieve(allocator: std.mem.Allocator, n: usize) ![]i32 {
    var isPrime = try allocator.alloc(bool, n + 1);
    defer allocator.free(isPrime);

    for (2..n + 1) |i| {
        isPrime[i] = true;
    }

    for (2..n + 1) |num| {
        if (isPrime[num]) {
            var ct = num * num;

            while (ct <= n) : (ct += num) {
                isPrime[ct] = false;
            }
        }
    }

    var result: std.ArrayList(i32) = .empty;
    defer result.deinit(allocator);

    for (2..n + 1) |num| {
        if (isPrime[num]) {
            try result.append(allocator, @as(i32, @intCast(num)));
        }
    }

    return result.toOwnedSlice(allocator);
}

fn solution(allocator: std.mem.Allocator, left: usize, right: usize) ![2]i32 {
    const primes = try sieve(allocator, right);
    defer allocator.free(primes);

    var best = [2]i32{ -1, -1 };
    var mini: i32 = std.math.maxInt(i32);

    for (0..primes.len) |idx| {
        if (primes[idx] >= left and idx + 1 < primes.len and primes[idx + 1] - primes[idx] < mini) {
            best = [2]i32{ primes[idx], primes[idx + 1] };
            mini = primes[idx + 1] - primes[idx];
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const left = 10;
    const right = 19;

    const expected = [2]i32{ 11, 13 };
    const actual = try solution(allocator, left, right);

    try expect(expected[0], actual[0]);
    try expect(expected[1], actual[1]);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const left = 4;
    const right = 6;

    const expected = [2]i32{ -1, -1 };
    const actual = try solution(allocator, left, right);

    try expect(expected[0], actual[0]);
    try expect(expected[1], actual[1]);
}
