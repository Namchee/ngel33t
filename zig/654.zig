const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode,
    right: ?*TreeNode,
};

fn solution(nums: []i32, alloc: std.mem.Allocator) !?*TreeNode {
    if (nums.len == 0) {
        return null;
    }

    var middle: usize = 0;

    for (nums, 0..) |num, idx| {
        if (num > nums[middle]) {
            middle = idx;
        }
    }

    const root = try alloc.create(TreeNode);
    root.val = nums[middle];
    root.left = try solution(nums[0..middle], alloc);
    root.right = try solution(nums[middle + 1 ..], alloc);

    return root;
}

fn cleanup(node: *TreeNode, alloc: std.mem.Allocator) void {
    if (node) |n| {
        cleanup(alloc, n.left);
        cleanup(alloc, n.right);
        alloc.destroy(n);
    }
}
