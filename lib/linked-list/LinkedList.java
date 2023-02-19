import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashSet;

class Node {
    int value;
    Node next;

    public Node(int value) {
        this.value = value;
        this.next = null;
    }
}

class LinkedList {
    Node head;

    public LinkedList() {
        this.head = null;
    }

    public LinkedList(int value) {
        this.head = new Node(value);
    }

    public void append(int value) {
        Node newNode = new Node(value);
        if (this.head == null) {
            this.head = newNode;
            return;
        }

        Node curr = this.head;
        while (curr.next != null) {
            curr = curr.next;
        }

        curr.next = newNode;
    }

    public String members() {
        ArrayList<String> mem = new ArrayList<>();
        Node curr = this.head;
        while (curr != null) {
            mem.add(Integer.toString(curr.value, 10));
            curr = curr.next;
        }

        return String.join("->", mem);
    }

    public int length() {
        int len = 0;
        Node curr = this.head;
        while (curr != null) {
            len++;
            curr = curr.next;
        }

        return len;
    }

    // Remove duplicate
    // Time complexity: O(n^2)
    public void removeDuplicates() {
        Node curr = this.head;

        while (curr != null) {
            Node cursor = curr;

            while (cursor.next != null) {
                if (curr.value == cursor.next.value) {
                    cursor.next = cursor.next.next;
                } else {
                    cursor = cursor.next;
                }
            }

            curr = curr.next;
        }
    }

    // With hashing
    // Time complexity: O(n)
    // Space complexity: O(n)
    public void removeDuplicatesWithSet() {
        Node curr = this.head;
        Node cursor = this.head;
        HashSet<Integer> set = new HashSet<>();

        while (curr != null) {
            if (set.contains(curr.value)) {
                cursor.next = curr.next;
            } else {
                set.add(curr.value);
                cursor = curr;
            }

            curr = curr.next;
        }
    }

    // Delete a given key
    // Time complexity: O(n)
    public void deleteKey(int value) {
        // set the head correctly
        while (this.head.value == value) {
            this.head = this.head.next;
        }

        Node curr = this.head;
        Node prev = null;

        while (curr != null) {
            if (curr.value == value) {
                prev.next = curr.next;
            } else {
                prev = curr;
            }

            curr = curr.next;
        }
    }

    // Reverse the linked list
    // Time complexity: O(n)
    public void reverse() {
        Node curr = this.head;
        Node prev = null;
        Node next = null;

        while (curr != null) {
            next = curr.next;
            curr.next = prev;

            prev = curr;
            curr = next;
        }

        this.head = prev;
    }
}

class Main {
    public static void main(String[] args) throws IOException {
        String in;
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        LinkedList li = new LinkedList();

        while ((in = br.readLine()) != null) {
            int val = Integer.parseInt(in, 10);
            if (val <= 0) {
                break;
            }

            li.append(val);
        }

        System.out.println(li.members());
        System.out.println(li.length());

        li.reverse();

        System.out.println(li.members());
    }
}