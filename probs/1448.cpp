
struct TreeNode
{
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution
{
public:
    int goodNodes(TreeNode *root)
    {
        countGoodNodes(root, root->val);

        return res;
    }

private:
    int res = 0;

    void countGoodNodes(TreeNode *root, int largest)
    {
        if (root == nullptr)
        {
            return;
        }

        if (largest <= root->val)
        {
            res++;
        }

        largest = max(largest, root->val);

        countGoodNodes(root->left, largest);
        countGoodNodes(root->right, largest);
    }
};
