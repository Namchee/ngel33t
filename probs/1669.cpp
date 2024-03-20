
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
    ListNode *mergeInBetween(ListNode *list1, int a, int b, ListNode *list2)
    {
        int c = 0;

        ListNode *prev = nullptr;
        ListNode *curr = list1;

        while (c < a)
        {
            c++;
            prev = curr;
            curr = curr->next;
        }

        while (c <= b)
        {
            c++;
            curr = curr->next;
        }

        prev->next = list2;

        prev = nullptr;
        ListNode *curr2 = list2;
        while (curr2 != nullptr)
        {
            prev = curr2;
            curr2 = curr2->next;
        }

        prev->next = curr;

        return list1;
    }
};
