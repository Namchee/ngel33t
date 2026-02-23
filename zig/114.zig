const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode,
    right: ?*TreeNode,
};

fn solution(node: ?*TreeNode) ?*TreeNode {
    return flattenTree(node, null);
}

fn flattenTree(node: ?*TreeNode, current_prev: ?*TreeNode) ?*TreeNode {
    if (node == null) {
        return node;
    }

    var prev = current_prev;

    prev = flattenTree(node.?.right, prev);
    prev = flattenTree(node.?.left, prev);

    node.?.right = prev;
    node.?.left = null;

    return node;
}
