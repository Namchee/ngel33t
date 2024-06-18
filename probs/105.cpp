#include <vector>
#include <algorithm>
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
    TreeNode *buildTree(vector<int> &preorder, vector<int> &inorder)
    {
        if (preorder.empty() || inorder.empty())
        {
            return nullptr;
        }

        TreeNode *root = new TreeNode(preorder[0]);
        auto mid = find(inorder.begin(), inorder.end(), preorder[0]) - inorder.begin();
        vector<int> leftP(preorder.begin() + 1, preorder.begin() + mid + 1);
        vector<int> rightP(preorder.begin() + mid + 1, preorder.end());
        vector<int> leftI(inorder.begin(), inorder.begin() + mid);
        vector<int> rightI(inorder.begin() + mid + 1, inorder.end());

        root->left = buildTree(leftP, leftI);
        root->right = buildTree(rightP, rightI);

        return root;
    }
};
