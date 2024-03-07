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
    ListNode* middleNode(ListNode* head) {
        if (head == nullptr) {
            return nullptr;
        }
        int len = 0;

        ListNode* curr = head;
        while (curr != nullptr) {
            len++;
            curr = curr->next;
        }
        
        int idx = 0;
        curr = head;
        while (idx < len / 2) {
            idx++;
            curr = curr->next;
        }

        return curr;
    }
};
