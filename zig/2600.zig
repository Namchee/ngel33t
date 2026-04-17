const std = @import("std");

fn solution(numOnes: i32, numsZeros: i32, numNegOnes: i32, ki: i32) i32 {
    var one = numOnes;
    var zero = numsZeros;
    var bad = numNegOnes;
    var k = ki;

    var result: i32 = 0;

    while (k > 0 and one > 0) {
        k -= 1;
        one -= 1;
        result += 1;
    }

    while (k > 0 and zero > 0) {
        k -= 1;
        zero -= 1;
    }

    while (k > 0 and bad > 0) {
        k -= 1;
        bad -= 1;
        result -= 1;
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const numOnes = 3;
    const numZeros = 2;
    const numNegOnes = 0;
    const k = 2;

    const expected = 2;
    const actual = solution(numOnes, numZeros, numNegOnes, k);

    try expect(expected, actual);
}

test "test case #2" {
    const numOnes = 3;
    const numZeros = 2;
    const numNegOnes = 0;
    const k = 4;

    const expected = 3;
    const actual = solution(numOnes, numZeros, numNegOnes, k);

    try expect(expected, actual);
}
