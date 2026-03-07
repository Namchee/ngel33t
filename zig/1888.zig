const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8) !usize {
    const rotation = try std.fmt.allocPrint(allocator, "{s}{s}", .{ s, s });
    defer allocator.free(rotation);

    var zeroDiff: usize = 0;
    var oneDiff: usize = 0;

    var best = s.len;

    for (0..rotation.len) |idx| {
        var zeroFirst: u8 = '1';
        var oneFirst: u8 = '0';

        if (@mod(idx, 2) == 0) {
            zeroFirst = '0';
            oneFirst = '1';
        }

        if (rotation[idx] != zeroFirst) {
            zeroDiff += 1;
        }

        if (rotation[idx] != oneFirst) {
            oneDiff += 1;
        }

        if (idx >= s.len) {
            const left = idx - s.len;

            var zeroLeft: u8 = '1';
            var oneLeft: u8 = '0';

            if (@mod(left, 2) == 0) {
                zeroLeft = '0';
                oneLeft = '1';
            }

            if (rotation[left] != zeroLeft) {
                zeroDiff -= 1;
            }

            if (rotation[left] != oneLeft) {
                oneDiff -= 1;
            }
        }

        if (idx >= s.len - 1) {
            best = @min(best, zeroDiff, oneDiff);
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const input = "111000";
    const expected = 2;

    const sol = try solution(allocator, input);

    try expect(expected, sol);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const input = "010";
    const expected = 0;

    const sol = try solution(allocator, input);

    try expect(expected, sol);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const input = "1110";
    const expected = 1;

    const sol = try solution(allocator, input);

    try expect(expected, sol);
}
