#include <vector>
using namespace std;

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
    TreeNode *bstToGst(TreeNode *root)
    {
        vector<TreeNode *> nodes;

        inorder(root, nodes);

        for (int i = nodes.size() - 2; i >= 0; i--)
        {
            nodes[i]->val += nodes[i + 1]->val;
        }

        return root;
    }

private:
    void inorder(TreeNode *curr, vector<TreeNode *> &nodes)
    {
        if (!curr)
        {
            return;
        }

        inorder(curr->left, nodes);
        nodes.push_back(curr);
        inorder(curr->right, nodes);
    }
};
