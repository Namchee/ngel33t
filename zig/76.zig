const std = @import("std");

fn sub_slice(a: []i32, b: []i32) bool {
    var idx: usize = 0;

    while (idx < 26) : (idx += 1) {
        if (a[idx] < b[idx]) {
            return false;
        }
    }

    return true;
}

fn solution(dict: []const u8, t: []const u8) []const u8 {
    var target = [_]i32{0} ** 26;
    for (t) |ch| {
        target[ch - 'A'] += 1;
    }

    var bl: usize = 0;
    var br: usize = dict.len + 1;

    var current = [_]i32{0} ** 26;

    var left: usize = 0;
    var right: usize = 0;

    while (right < dict.len) {
        current[dict[right] - 'A'] += 1;
        right += 1;

        while (sub_slice(&current, &target)) {
            const len = right - left + 1;
            const bestLen = br - bl + 1;

            if (bestLen == dict.len + 2 or bestLen > len) {
                bl = left;
                br = right;
            }

            current[dict[left] - 'A'] -= 1;
            left += 1;
        }
    }

    const bestLen = br - bl + 1;

    if (bestLen == dict.len + 2) {
        return "";
    }

    return dict[bl..br];
}

const expect = std.testing.expect;

test "test case #1" {
    const dict = "ADOBECODEBANC";
    const t = "ABC";

    const sol = solution(dict, t);

    try expect(std.mem.eql(u8, sol, "BANC"));
}

test "test case #2" {
    const dict = "A";
    const t = "A";

    const sol = solution(dict, t);

    try expect(std.mem.eql(u8, sol, "A"));
}

test "test case #3" {
    const dict = "A";
    const t = "AA";

    const sol = solution(dict, t);

    try expect(std.mem.eql(u8, sol, ""));
}
