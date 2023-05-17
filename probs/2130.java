import java.util.List;
import java.util.ArrayList;

class ListNode {
    int val;
    ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

class Solution {
    public int pairSum(ListNode head) {
        List<Integer> arr = toArray(head);

        int len = arr.size();
        int best = 0;

        for (int idx = 0; idx < len / 2; idx++) {
            best = Math.max(
                best,
                arr.get(idx) + arr.get(len - 1 - idx)
            );
        }

        return best;
    }

    List<Integer> toArray(ListNode head) {
        List<Integer> result = new ArrayList<>();
        ListNode curr = head;

        while (curr != null) {
            result.add(curr.val);
            curr = curr.next;
        }

        return result;
    }
}
