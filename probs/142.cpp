struct ListNode
{
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution
{
public:
    ListNode *detectCycle(ListNode *head)
    {
        ListNode *tortoise = head;
        ListNode *hare = head;

        bool hasLoop = false;

        while (tortoise != nullptr && hare != nullptr && hare->next != nullptr && !hasLoop)
        {
            tortoise = tortoise->next;
            hare = hare->next->next;

            if (tortoise == hare)
            {
                hasLoop = true;
            }
        }

        if (!hasLoop)
        {
            return nullptr;
        }

        int nu = 0;
        tortoise = head;

        while (tortoise != hare)
        {
            tortoise = tortoise->next;
            hare = hare->next;
            nu++;
        }

        tortoise = head;
        while (nu-- > 0)
        {
            tortoise = tortoise->next;
        }

        return tortoise;
    }
};
