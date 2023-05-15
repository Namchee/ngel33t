import java.util.List;
import java.util.ArrayList;

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
    public List<String> binaryTreePaths(TreeNode root) {
        ArrayList<String> result = new ArrayList<>();

        this.traverse(result, root, "");

        return result;
    }

    private void traverse(List<String> result, TreeNode curr, String path) {
        if (curr == null) {
            return;
        }

        if (path.length() > 0) {
            path += "->";
        }

        path += Integer.toString(curr.val);

        if (curr.left == null && curr.right == null) {
            result.add(path);
            return;
        }

        traverse(result, curr.left, path);
        traverse(result, curr.right, path);
    }
}