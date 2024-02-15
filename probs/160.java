public class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        List<ListNode> nodeList = new ArrayList();

        while (headA != null) {
            nodeList.add(headA);
            headA = headA.next;
        }

        while (headB != null) {
            if (nodeList.contains(headB)) {
                return headB;
            }

            headB = headB.next;
        }

        return null;
    }
}
