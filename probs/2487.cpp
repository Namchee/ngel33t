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
    ListNode *removeNodes(ListNode *head)
    {
        vector<int> temp;
        ListNode *curr = head;
        while (curr != nullptr)
        {
            temp.push_back(curr->val);

            curr = curr->next;
        }

        vector<int> maxi(temp.size(), -1);
        for (int idx = temp.size() - 2; idx >= 0; idx--)
        {
            maxi[idx] = max(maxi[idx + 1], temp[idx + 1]);
        }

        ListNode *result = nullptr;
        ListNode *runner = nullptr;

        for (int i = 0; i < temp.size(); i++)
        {
            if (maxi[i] <= temp[i])
            {
                if (result == nullptr)
                {
                    result = new ListNode(temp[i]);
                    runner = result;
                }
                else
                {
                    runner->next = new ListNode(temp[i]);
                    runner = runner->next;
                }
            }
        }

        return result;
    }
};
