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
    public List<List<Integer>> pathSum(TreeNode root, int targetSum) {
        List<List<Integer>> result = new ArrayList<>();

        this.traverse(result, new ArrayList<>(), root, targetSum, 0);

        return result;
    }

    private void traverse(
            List<List<Integer>> result,
            List<Integer> path,
            TreeNode curr,
            int target,
            int c) {
        if (curr == null) {
            return;
        }

        if (target == c + curr.val && curr.left == null && curr.right == null) {
            List<Integer> p = new ArrayList<>(path);
            p.add(curr.val);
            result.add(p);

            return;
        }

        path.add(curr.val);

        traverse(result, path, curr.left, target, c + curr.val);
        traverse(result, path, curr.right, target, c + curr.val);

        path.remove(path.size() - 1);
    }
}