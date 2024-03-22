#include <stack>;
using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};
 
class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        if (head == nullptr) {
            return nullptr;
        }

        stack<ListNode*> stk;

        ListNode* curr = head;
        while (curr != nullptr) {
            stk.push(curr);
            curr = curr->next;
        }

        ListNode* newHead = stk.top();
        curr = newHead;
        stk.pop();
        
        while (!stk.empty()) {
            curr->next = stk.top();
            stk.pop();
            curr = curr->next;
        }

        curr->next = nullptr;

        return newHead;
    }
};