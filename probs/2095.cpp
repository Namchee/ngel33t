struct ListNode
{
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    ListNode* deleteMiddle(ListNode* head) {
        int len = 0;

        ListNode* curr = head;
        while (curr != nullptr) {
            len++;
            curr = curr->next;
        }

        if (len <= 1) {
            return nullptr;
        }

        int cut_off = (len / 2) - 1;
        int idx = 0;
        curr = head;

        while (idx < cut_off) {
            idx++;
            curr = curr->next;
        }

        if (curr->next != nullptr) {
            curr->next = curr->next->next;
        } else {
            curr->next = nullptr;
        }

        return head;
    }
};
