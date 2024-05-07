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
    ListNode *doubleIt(ListNode *head)
    {
        if (head->val == 0)
        {
            return head;
        }

        vector<int> temp;
        ListNode *curr = head;

        while (curr != nullptr)
        {
            temp.push_back(curr->val);
            curr = curr->next;
        }

        multiply(temp);

        ListNode *result = nullptr;
        ListNode *runner = nullptr;

        for (int i = 0; i < temp.size(); i++)
        {
            ListNode *node = new ListNode(temp[i]);
            if (result == nullptr)
            {
                result = node;
                runner = node;
            }
            else
            {
                runner->next = node;
                runner = runner->next;
            }
        }

        return result;
    }

private:
    void multiply(vector<int> &src)
    {
        int rem = 0;
        for (int i = src.size() - 1; i >= 0; i--)
        {
            int sum = (src[i] * 2) + rem;
            int val = sum % 10;
            rem = sum >= 10 ? 1 : 0;

            src[i] = val;
        }

        if (rem)
        {
            src.insert(src.begin(), rem);
        }
    }
};
