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
    public ListNode deleteDuplicates(ListNode head) {
        ListNode curr = head;

        while (curr != null) {
            ListNode cursor = curr;

            while (cursor.next != null) {
                if (curr.val == cursor.next.val) {
                    cursor.next = cursor.next.next;
                } else {
                    cursor = cursor.next;
                }
            }

            curr = curr.next;
        }

        return head;
    }
}