const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode = null,
    right: ?*TreeNode = null,
};

fn solution(allocator: std.mem.Allocator, root: ?*TreeNode) ![][]i32 {
    if (root == null) return &[_][]i32{};

    var result: std.ArrayList([]i32) = .empty;
    errdefer {
        for (result.items) |level| allocator.free(level);
        result.deinit(allocator);
    }

    var queue: std.ArrayList(*TreeNode) = .empty;
    defer queue.deinit(allocator);

    try queue.append(allocator, root.?);

    while (queue.items.len > 0) {
        const level_size = queue.items.len;
        var current_level = try std.ArrayList(i32).initCapacity(allocator, level_size);
        errdefer current_level.deinit(allocator);

        for (0..level_size) |_| {
            const node = queue.orderedRemove(0);
            current_level.appendAssumeCapacity(node.val);

            if (node.left) |left| try queue.append(allocator, left);
            if (node.right) |right| try queue.append(allocator, right);
        }

        try result.append(allocator, try current_level.toOwnedSlice(allocator));
    }

    std.mem.reverse([]i32, result.items);

    return result.toOwnedSlice(allocator);
}

test "level order bottom" {
    const alloc = std.testing.allocator;

    var leaf1 = TreeNode{ .val = 15 };
    var leaf2 = TreeNode{ .val = 7 };
    var mid1 = TreeNode{ .val = 20, .left = &leaf1, .right = &leaf2 };
    var mid2 = TreeNode{ .val = 9 };
    var root = TreeNode{ .val = 3, .left = &mid2, .right = &mid1 };

    const res = try solution(alloc, &root);

    defer {
        for (res) |level| alloc.free(level);
        alloc.free(res);
    }

    try std.testing.expectEqual(@as(usize, 3), res.len);
    try std.testing.expectEqual(leaf1.val, res[0][0]);
    try std.testing.expectEqual(leaf2.val, res[0][1]);
}
