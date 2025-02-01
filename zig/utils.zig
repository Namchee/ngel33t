pub fn isEqual(comptime T: type, a: []T, b: []T) bool {
    if (a.len != b.len) {
        return false;
    }

    var idx: usize = 0;
    while (idx < a.len) : (idx += 1) {
        if (a[idx] != b[idx]) {
            return false;
        }
    }

    return true;
}
