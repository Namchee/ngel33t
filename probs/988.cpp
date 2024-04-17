#include <string>
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
    string smallestFromLeaf(TreeNode *root)
    {
        return traverse(root, "");
    }

private:
    string traverse(TreeNode *curr, string str)
    {
        if (curr == nullptr)
        {
            return str;
        }

        str = (char)(curr->val + 'a') + str;

        if (curr->left == nullptr && curr->right == nullptr)
        {
            return str;
        }

        if (curr->left == nullptr && curr->right != nullptr)
        {
            return traverse(curr->right, str);
        }

        if (curr->left != nullptr && curr->right == nullptr)
        {
            return traverse(curr->left, str);
        }

        string left = traverse(curr->left, str);
        string right = traverse(curr->right, str);

        if (left.find(right) == 0)
        {
            return right;
        }

        if (right.find(left) == 0)
        {
            return left;
        }

        return left < right ? left : right;
    }
};
