#include <unordered_map>;
using namespace std;

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
    ListNode* removeZeroSumSublists(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        int sum = 0;

        unordered_map<int, ListNode*> pos;
        pos[0] = dummy;

        ListNode* curr = head;

        while (curr) {
            sum += curr->val;

            if (pos.find(sum) != pos.end()) {
                ListNode* walker = pos[sum]->next;
                int temp = sum + walker->val;

                while (walker != curr) {
                    pos.erase(temp);
                    walker = walker->next;
                    temp += walker->val;
                }

                pos[sum]->next = curr->next;
            } else {
                pos[sum] = curr;
            }

            curr = curr->next;
        }

        return dummy->next;
    }
};
