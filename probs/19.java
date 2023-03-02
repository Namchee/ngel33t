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
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode p1 = head;
        ListNode p2 = head;
        ListNode prev = null;

        for (int i = 0; i < n; i++) {
            if (p1 == null) {
                return head; // harusnya lu ga bisa remove ini
            }
            p1 = p1.next;
        }

        while (p1 != null) {
            prev = p2;
            p1 = p1.next;
            p2 = p2.next;
        }

        if (p2 == head) {
            return head.next;
        }

        if (prev != null) {
            prev.next = p2.next;
            return head;
        }

        return null;
    }
}