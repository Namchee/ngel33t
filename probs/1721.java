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
    public ListNode swapNodes(ListNode head, int k) {
        List<Integer> temp = toArray(head);

        k -= 1;
        int l = temp.size() - 1 - k;

        if (k == l) {
            return toList(temp);
        }

        temp.set(k, temp.get(k) + temp.get(l));
        temp.set(l, temp.get(k) - temp.get(l));
        temp.set(k, temp.get(k) - temp.get(l));

        return toList(temp);
    }

    List<Integer> toArray(ListNode head) {
        List<Integer> res = new ArrayList<>();

        while (head != null) {
            res.add(head.val);
            head = head.next;
        }

        return res;
    }

    ListNode toList(List<Integer> arr) {
        ListNode head = new ListNode(arr.get(0));
        ListNode curr = head;

        for (int idx = 1; idx < arr.size(); idx++) {
            ListNode newNode = new ListNode(arr.get(idx));
            curr.next = newNode;
            curr = curr.next;
        }

        return head;
    }
}