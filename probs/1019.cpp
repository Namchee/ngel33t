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

class Solution
{
public:
    vector<int> nextLargerNodes(ListNode *head)
    {
        vector<int> result;

        ListNode *curr = head;
        while (curr != nullptr)
        {
            ListNode *runner = curr->next;
            int best = 0;

            while (runner != nullptr)
            {
                if (runner->val > curr->val)
                {
                    best = runner->val;
                    break;
                }

                runner = runner->next;
            }

            result.push_back(best);
            curr = curr->next;
        }

        return result;
    }
};
