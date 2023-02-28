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
    public String smallestFromLeaf(TreeNode root) {
        return this.getBest(new ArrayList<>(), root);
    }

    public String getBest(
            List<Integer> path,
            TreeNode curr) {
        if (curr == null) {
            return "123";
        }

        if (curr.left == null && curr.right == null) {
            StringBuilder sb = new StringBuilder();
            sb.append((char) (curr.val + 'a'));

            for (int i = path.size() - 1; i >= 0; i--) {
                sb.append((char) (path.get(i) + 'a'));
            }

            return sb.toString();
        }

        path.add(curr.val);

        String left = this.getBest(path, curr.left);
        String right = this.getBest(path, curr.right);

        path.remove(path.size() - 1);

        if (left == "123") {
            return right;
        }

        if (right == "123") {
            return left;
        }

        if (left.compareTo(right) < 0) {
            return left;
        }

        return right;
    }
}