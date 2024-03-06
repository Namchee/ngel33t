struct ListNode
{
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution
{
public:
    bool hasCycle(ListNode *head)
    {
        ListNode *tortoise = head;
        ListNode *hare = head;

        while (tortoise != nullptr && hare != nullptr && hare->next != nullptr)
        {
            tortoise = tortoise->next;
            hare = hare->next->next;

            if (tortoise == hare)
            {
                return true;
            }
        }

        return false;
    }
};
