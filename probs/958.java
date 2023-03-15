class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;

    TreeNode() {
    }

    TreeNode(int val) {
        this.val = val;
    }

    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

class Solution {
    public boolean isCompleteTree(TreeNode root) {
        int nodes = this.countNode(root);

        return this.isCompleteTree(root, 0, nodes);
    }

    private boolean isCompleteTree(TreeNode curr, int index, int num) {
        if (curr == null) {
            return true;
        }

        if (index >= num) {
            return false;
        }

        return this.isCompleteTree(curr.left, 2 * index + 1, num)
                && this.isCompleteTree(curr.right, 2 * index + 2, num);
    }

    private int countNode(TreeNode root) {
        if (root == null) {
            return 0;
        }

        return 1 + this.countNode(root.left) + this.countNode(root.right);
    }
}