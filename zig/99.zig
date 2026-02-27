const std = @import("std");

const TreeNode = struct {
    val: i32,
    left: ?*TreeNode = null,
    right: ?*TreeNode = null,
};

const TreeState = struct { prev: ?*TreeNode = null, first: ?*TreeNode = null, second: ?*TreeNode = null };

fn traverse(node: ?*TreeNode, state: *TreeState) void {
    if (node) |n| {
        traverse(n.left, state);
        if (state.prev) |prev| {
            if (prev.val >= n.val) {
                if (state.first == null) {
                    state.first = prev;
                }

                state.second = n;
            }
        }

        state.prev = node;
        traverse(n.right, state);
    }
}

fn solution(root: ?*TreeNode) void {
    if (root == null) {
        return;
    }

    var state = TreeState{};
    traverse(root, &state);

    if (state.first) |first| {
        if (state.second) |second| {
            const temp = first.val;
            first.val = second.val;
            second.val = temp;
        }
    }
}
