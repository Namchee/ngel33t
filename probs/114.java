class ListNode {
    int val;
    ListNode next;

    ListNode() {
    }

    ListNode(int val) {
        this.val = val;
    }

    ListNode(int val, ListNode next) {
        this.val = val;
        this.next = next;
    }
}

class Solution {
    public boolean hasCycle(ListNode head) {
        if (head == null) {
            return false;
        }

        ListNode tortoise = head;
        ListNode hare = head.next;

        while (tortoise != null && hare != null) {
            tortoise = tortoise.next;
            hare = hare.next;

            if (hare == null || hare.next == null) {
                return false;
            }

            hare = hare.next;

            if (tortoise != null && hare != null && tortoise == hare) {
                return true;
            }
        }

        return false;
    }
}