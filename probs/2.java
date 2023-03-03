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
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode p1 = l1;
        ListNode p2 = l2;

        ListNode result = null;
        ListNode head = result;

        int borrow = 0;

        while (p1 != null && p2 != null) {
            int val = p1.val + p2.val + borrow;
            if (val / 10 > 0) {
                borrow = 1;
            } else {
                borrow = 0;
            }

            if (result == null) {
                result = new ListNode();
                head = result;

                result.val = val % 10;
            } else {
                ListNode nxt = new ListNode(val % 10);
                result.next = nxt;
                result = result.next;
            }

            p1 = p1.next;
            p2 = p2.next;
        }

        while (p1 != null) {
            int val = p1.val + borrow;
            if (val / 10 > 0) {
                borrow = 1;
            } else {
                borrow = 0;
            }

            if (result == null) {
                result = new ListNode();
                head = result;

                result.val = val % 10;
            } else {
                ListNode nxt = new ListNode(val % 10);
                result.next = nxt;
                result = result.next;
            }

            p1 = p1.next;
        }

        while (p2 != null) {
            int val = p2.val + borrow;
            if (val / 10 > 0) {
                borrow = 1;
            } else {
                borrow = 0;
            }

            if (result == null) {
                result = new ListNode();
                head = result;

                result.val = val % 10;
            } else {
                ListNode nxt = new ListNode(val % 10);
                result.next = nxt;
                result = result.next;
            }

            p2 = p2.next;
        }

        if (borrow > 0) {
            if (result == null) {
                result = new ListNode();
                head = result;

                result.val = 1;
            } else {
                ListNode nxt = new ListNode(1);
                result.next = nxt;
                result = result.next;
            }
        }

        return head;
    }
}