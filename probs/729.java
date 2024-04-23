class Node {
    int start, end;
    Node left, right;

    public Node(int start, int end) {
        this.start = start;
        this.end = end;
    }
}

class MyCalendar {
    Node root;

    public MyCalendar() {
        this.root = null;
    }
    
    public boolean book(int start, int end) {
        if (this.root == null) {
            Node newNode = new Node(start, end);
            this.root = newNode;
            return true;
        }

        return insertNode(start, end, this.root);
    }

    private boolean insertNode(int start, int end, Node curr) {
        if (curr.start >= end) {
            if (curr.left == null) {
                curr.left = new Node(start, end);
                return true;
            }

            return insertNode(start, end, curr.left);
        } else if (curr.end <= start) {
            if (curr.right == null) {
                curr.right = new Node(start, end);
                return true;
            }

            return insertNode(start, end, curr.right);
        }

        return false;
    }
}

/**
 * Your MyCalendar object will be instantiated and called as such:
 * MyCalendar obj = new MyCalendar();
 * boolean param_1 = obj.book(start,end);
 */
