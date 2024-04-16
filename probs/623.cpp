
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
    TreeNode *addOneRow(TreeNode *root, int val, int depth)
    {
        if (depth == 1)
        {
            TreeNode *neue = new TreeNode(val);
            if (root != nullptr)
            {
                neue->left = root;
            }

            return neue;
        }

        traverse(root, val, depth, 1);
        return root;
    }

private:
    void traverse(TreeNode *curr, int val, int depth, int ct)
    {
        if (curr == nullptr)
        {
            return;
        }

        if (ct == depth - 1)
        {
            TreeNode *l = curr->left;
            TreeNode *r = curr->right;

            TreeNode *a = new TreeNode(val);
            TreeNode *b = new TreeNode(val);

            a->left = l;
            b->right = r;

            curr->left = a;
            curr->right = b;

            return;
        }

        traverse(curr->left, val, depth, ct + 1);
        traverse(curr->right, val, depth, ct + 1);
    }
};
