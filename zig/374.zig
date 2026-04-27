const std = @import("std");

// sample API
fn guess() i32 {
    return -1;
}

fn solution(n: i32) i32 {
    var left: i32 = 0;
    var right: i32 = n;

    while (left <= right) {
        var mid = left + @divExact(right - left, 2);
        const res = guess();

        if (res == 0) {
            return mid;
        }

        if (res == -1) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return left + @divExact(right - left, 2);
}
