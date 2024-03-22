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
    bool isPalindrome(ListNode *head)
    {
        ListNode *tortoise = head;
        ListNode *hare = head;

        while (hare != nullptr && hare->next != nullptr)
        {
            tortoise = tortoise->next;
            hare = hare->next->next;
        }   

        ListNode *reversed = reverse(tortoise);
        while (reversed != nullptr)
        {
            if (reversed->val != head->val)
            {
                return false;
            }

            head = head->next;
            reversed = reversed->next;
        }

        return true;
    }

private:
    ListNode *reverse(ListNode *head)
    {
        ListNode *prev = nullptr;
        ListNode *curr = head;

        while (curr != nullptr)
        {
            ListNode *temp = curr->next;
            curr->next = prev;
            prev = curr;
            curr = temp;
        }

        return prev;
    }
};
