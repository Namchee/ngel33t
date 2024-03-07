#include <vector>;
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
    void reorderList(ListNode* head) {
        vector<ListNode*> temp;
        ListNode* curr = head;

        while (curr != nullptr) {
            temp.push_back(curr);
            curr = curr->next;
        }

        int l = 1;
        int r = temp.size() - 1;

        curr = head;

        while (l <= r && l < temp.size() && r >= 0) {
            if (temp[r] == head) {
                break;
            }

            curr->next = temp[r--];
            curr = curr->next;

            if (l > r) {
                break;
            }

            curr->next = temp[l++];
            curr = curr->next;
        }

        curr->next = nullptr;
    }
};
