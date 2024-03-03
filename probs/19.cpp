  struct ListNode {
      int val;
      ListNode *next;
      ListNode() : val(0), next(nullptr) {}
      ListNode(int x) : val(x), next(nullptr) {}
     ListNode(int x, ListNode *next) : val(x), next(next) {}

  };

class Solution {
public:
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        ListNode* p1 = head;
        ListNode* p2 = head;
        ListNode* prev = nullptr;

        for (int i = 0; i < n; i++) {
            if (p1 == nullptr) {
                return head;
            }

            p1 = p1->next;
        }

        while (p1 != nullptr) {
            prev = p2;
            p1 = p1->next;
            p2 = p2->next;
        }

        if (p2 == head) {
            return head->next;
        }

        if (prev != nullptr) {
            prev->next = p2->next;

            return head;
        }

        return nullptr;
    }
};
