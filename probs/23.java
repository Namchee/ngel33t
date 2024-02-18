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
    public ListNode mergeKLists(ListNode[] lists) {
        ListNode result = null;
        ListNode head = null;

        while (true) {
            ListNode best = null;
            int bestIdx = -1;

            for (int idx = 0; idx < lists.length; idx++) {
                if (best == null || (lists[idx] != null && lists[idx].val < best.val)) {
                    best = lists[idx];
                    bestIdx = idx;
                }
            }

            if (best == null) {
                break;
            }

            if (result == null) {
                result = best;
                head = result;
            } else {
                result.next = best;
                result = result.next;
            }

            lists[bestIdx] = lists[bestIdx].next;
        }

        return head;
    }
}
