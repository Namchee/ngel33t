#include <utility>;
#include <climits>;
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

class Solution {
public:
    int findBottomLeftValue(TreeNode* root) {
        pair<int, int> result = traverse(root, 0);

        return result.first; 
    }

    pair<int, int> traverse(TreeNode* root, int depth) {
        if (root == nullptr) {
            return { 0, INT_MIN };
        }

        if (root->left == nullptr && root->right == nullptr) {
            return { root->val, depth };
        }

        pair<int, int> leftTree = traverse(root->left, depth + 1);
        pair<int, int> rightTree = traverse(root->right, depth + 1);

        return rightTree.second > leftTree.second ? rightTree : leftTree;
    }
};
