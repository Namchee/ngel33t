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
}
