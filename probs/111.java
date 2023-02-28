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
    public int minDepth(TreeNode root) {
        if (root == null) {
            return 0;
        }

        if (root.left == null && root.right == null) {
            return 1;
        }

        int min = 1000000000;

        if (root.left != null) {
            min = Math.min(min, 1 + this.minDepth(root.left));
        }
        if (root.right != null) {
            min = Math.min(min, 1 + this.minDepth(root.right));
        }

        return min;
    }
}