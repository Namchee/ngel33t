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
    TreeNode *balanceBST(TreeNode *root)
    {
        vector<TreeNode *> nodes;
        traverse(root, nodes);

        return buildTree(nodes);
    }

private:
    void traverse(TreeNode *curr, vector<TreeNode *> &nodes)
    {
        if (!curr)
        {
            return;
        }

        traverse(curr->left, nodes);
        nodes.push_back(curr);
        traverse(curr->right, nodes);
    }

    TreeNode *buildTree(vector<TreeNode *> nodes)
    {
        if (nodes.size() == 0)
        {
            return nullptr;
        }

        int mid = nodes.size() / 2;
        TreeNode *curr = nodes[mid];

        curr->left = buildTree(vector<TreeNode *>(nodes.begin(), nodes.begin() + mid));
        curr->right = buildTree(vector<TreeNode *>(nodes.begin() + mid + 1, nodes.end()));

        return curr;
    }
};
