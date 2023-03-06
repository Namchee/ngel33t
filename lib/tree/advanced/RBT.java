package advanced;

// Red-Black Tree, self balancing binary tree
// Time complexity: O(log n), insertion takes log n time.
// Space complexity: O(n), total number of elements
class RBT {
    static enum Color {
        Red,
        Black,
    };

    static class Node {
        int value;
        Node left, right;
        Color color;

        Node(int value) {
            this.value = value;
            this.left = null;
            this.right = null;
            this.color = Color.Red;
        }
    }

    Node root;

    public RBT() {
        this.root = null;
    }

    private Node rotateLeft(Node node) {
        Node x = node.right;
        node.right = x.left;
        x.left = node;
        x.color = node.color;
        node.color = Color.Red;

        return x;
    }

    private Node rotateRight(Node node) {
        Node x = node.left;
        node.left = node.right;
        x.right = node;
        x.color = node.color;
        node.color = Color.Red;

        return x;
    }

    private void flipColors(Node node) {
        node.color = Color.Red;
        node.left.color = Color.Black;
        node.right.color = Color.Black;
    }

    private boolean isRed(Node node) {
        if (node == null) {
            return false;
        }

        return node.color == Color.Red;
    }

    private Node insert(Node curr, int value) {
        if (curr == null) {
            return new Node(value);
        }

        if (value < curr.value) {
            curr.left = this.insert(curr.left, value);
        } else {
            curr.right = this.insert(curr.right, value);
        }

        if (!this.isRed(curr.left) && this.isRed(curr.right)) {
            curr = this.rotateLeft(curr);
        }

        if (this.isRed(curr.left) && this.isRed(curr.right)) {
            this.flipColors(curr);
        }

        return curr;
    }

    public Node insert(int value) {
        return this.insert(this.root, value);
    }

    public boolean search(int x) {
        Node cursor = this.root;

        while (cursor != null) {
            if (cursor.value == x) {
                return true;
            }

            if (cursor.value > x) {
                cursor = cursor.left;
            } else {
                cursor = cursor.right;
            }
        }

        return false;
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