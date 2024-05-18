#include <cmath>
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
    int distributeCoins(TreeNode *root, TreeNode *parent = nullptr)
    {
        if (root == nullptr)
        {
            return 0;
        }

        int left = distributeCoins(root->left, root);
        int right = distributeCoins(root->right, root);

        int moves = root->val - 1;
        if (parent)
        {
            parent->val += moves;
        }

        return left + right + abs(moves);
    }
};
