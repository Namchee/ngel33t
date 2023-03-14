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
    public int sumNumbers(TreeNode root) {
        if (root == null) {
            return 0;
        }

        return this.sumNumbers(root, "");
    }

    private int sumNumbers(TreeNode node, String num) {
        if (node == null) {
            return 0;
        }

        if (node.left == null && node.right == null) {
            return Integer.parseInt(num + Integer.toString(node.val));
        }

        num = num + Integer.toString(node.val);

        return this.sumNumbers(node.right, num) + this.sumNumbers(node.left, num);
    }
}