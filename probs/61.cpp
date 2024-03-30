#include <vector>
using namespace std;

struct ListNode
{
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution
{
public:
    ListNode *rotateRight(ListNode *head, int k)
    {
        if (head == nullptr)
        {
            return nullptr;
        }

        vector<ListNode *> temp;

        int len = 0;

        ListNode *curr = head;
        while (curr != nullptr)
        {
            temp.push_back(curr);
            curr = curr->next;
            len++;
        }

        int newHead = len - (k % len);
        if (newHead == len)
        {
            return head;
        }

        temp[newHead - 1]->next = nullptr;
        temp[temp.size() - 1]->next = temp[0];

        return temp[newHead];
    }
};
