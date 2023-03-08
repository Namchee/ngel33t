import java.util.ArrayList;

class Node {
    int value;
    Node left, right;

    public Node(int value) {
        this.value = value;
    }
}

// Binary search tree
public class BST {
    Node root;

    public BST() {
        this.root = null;
    }

    public BST(int value) {
        this.root = new Node(value);
    }

    public void addNode(int value) {
        Node newNode = new Node(value);
        if (this.root == null) {
            this.root = newNode;
            return;
        }

        Node parent = null;
        Node curr = this.root;
        while (curr != null) {
            parent = curr;

            if (curr.value <= value) {
                curr = curr.right;
            } else {
                curr = curr.left;
            }
        }

        if (parent.value <= value) {
            parent.right = newNode;
        } else {
            parent.left = newNode;
        }
    }

    public void inOrder() {
        this.inOrder(this.root);
    }

    private void inOrder(Node node) {
        if (node != null) {
            this.inOrder(node.left);
            System.out.println(node.value);
            this.inOrder(node.right);
        }
    }

    public void preOrder() {
        this.preOrder(this.root);
    }

    private void preOrder(Node node) {
        if (node != null) {
            System.out.println(node.value);
            this.inOrder(node.left);
            this.inOrder(node.right);
        }
    }

    public void postOrder() {
        this.postOrder(this.root);
    }

    private void postOrder(Node node) {
        if (node != null) {
            this.inOrder(node.left);
            this.inOrder(node.right);
            System.out.println(node.value);
        }
    }

    public int getHeight() {
        return this.getHeight(this.root);
    }

    private int getHeight(Node curr) {
        if (curr == null) {
            return 0;
        }

        return 1 + Math.max(this.getHeight(curr.left), this.getHeight(curr.right));
    }

    public boolean isBalanced() {
        return this.isBalanced(this.root);
    }

    private boolean isBalanced(Node curr) {
        if (curr == null) {
            return true; // a tree is balanced if it's empty
        }

        int leftHeight = this.getHeight(curr.left);
        if (leftHeight == -1) {
            return false;
        }

        int rightHeight = this.getHeight(curr.right);
        if (rightHeight == -1) {
            return false;
        }

        if (Math.abs(leftHeight - rightHeight) > 1) {
            return false;
        } else {
            return Math.max(leftHeight, rightHeight) + 1;
        }
    }

    public boolean isBST() {
        return this.isBST(this.root);
    }

    private boolean isBST(Node curr) {
        if (curr == null) {
            return true;
        }

        if (curr.left != null && curr.value < curr.left.value) {
            return false;
        }

        if (curr.right != null && curr.value >= curr.right.value) {
            return false;
        }

        return this.isBST(curr.left) && this.isBST(curr.right);
    }

    public int getLCA(int a, int b) {
        ArrayList<Integer> pathToA = new ArrayList<>();
        ArrayList<Integer> pathToB = new ArrayList<>();

        boolean hasPathToA = this.findPath(root, pathToA, a);
        boolean hasPathToB = this.findPath(root, pathToB, b);

        if (!hasPathToA || !hasPathToB) {
            return -1;
        }

        for (int idxA = pathToA.size() - 1; idxA >= 0; idxA--) {
            for (int idxB = pathToB.size() - 1; idxB >= 0; idxB--) {
                if (pathToA.get(idxA) == pathToB.get(idxB)) {
                    return pathToA.get(idxA); // this is the LCA
                }
            }
        }

        return -1;
    }

    private boolean findPath(
            Node curr,
            ArrayList<Integer> path,
            int target) {
        if (curr == null) {
            return false;
        }

        path.add(curr.value);
        if (curr.value == target) {
            return true;
        }

        if (this.findPath(curr.left, path, target) || this.findPath(curr.right, path, target)) {
            return true;
        }

        path.remove(path.size() - 1); // we don't need to visit this node
        return false;
    }
}
