package advanced;

import java.util.ArrayList;
import java.util.List;

// Balancing a binary search tree, using 
// Time complexity: O(n), first in-order traversal, and building the tree afterwards
// Space complexity: O(n), used to store the node values
class Balans {
    static class Node {
        int value;
        Node left, right;

        Node(int value) {
            this.value = value;
            this.left = null;
            this.right = null;
        }
    }

    Node root;

    public Balans() {
        this.root = null;
    }

    public void insert(int value) {
        Node newNode = new Node(value);
        if (this.root == null) {
            this.root = newNode;
            return;
        }

        Node crawler = this.root;
        Node prev = null;
        while (crawler != null) {
            prev = crawler;

            crawler = crawler.value > value ? crawler.left : crawler.right;
        }

        if (prev.value > value) {
            prev.left = newNode;
        } else {
            prev.right = newNode;
        }
    }

    public List<Integer> doInorder() {
        List<Integer> traversal = new ArrayList<>();

        this.doInorder(traversal, this.root);

        return traversal;
    }

    public void balanceTree() {
        List<Integer> order = this.doInorder();

        this.root = this.balanceTree(order, 0, order.size() - 1);
    }

    private Node balanceTree(List<Integer> order, int start, int end) {
        if (start > end) {
            return null;
        }

        int mid = start + (end - start) / 2;
        Node root = new Node(order.get(mid));

        root.left = this.balanceTree(order, start, mid - 1);
        root.right = this.balanceTree(order, mid + 1, end);

        return root;
    }

    private void doInorder(List<Integer> traversal, Node curr) {
        if (curr != null) {
            doInorder(traversal, curr.left);
            traversal.add(curr.value);
            doInorder(traversal, curr.right);
        }
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
        int rightHeight = this.getHeight(curr.right);

        return Math.abs(leftHeight - rightHeight) <= 0 && this.isBalanced(curr.left) && this.isBalanced(curr.right);
    }
}

class Main {
    public static void main(String[] args) {
        Balans tree = new Balans();
        tree.insert(10);
        tree.insert(8);
        tree.insert(7);
        tree.insert(6);
        tree.insert(5);
    }
}