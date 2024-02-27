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
    bool isValidBST(TreeNode* root) {
        if (root == nullptr) {
            return true;
        }

        bool hasLeftHigherEqual = hasHigherEqual(root->left, root->val);
        bool hasRightLowerEqual = hasLowerEqual(root->right, root->val);

        return !hasLeftHigherEqual && !hasRightLowerEqual && isValidBST(root->left) && isValidBST(root->right);
    }

    bool hasHigherEqual(TreeNode* node, int val) {
        if (node == nullptr) {
            return false;
        }

        if (node->val >= val) {
            return true;
        }

        return hasHigherEqual(node->left, val) || hasHigherEqual(node->right, val);
    }

    bool hasLowerEqual(TreeNode* node, int val) {
        if (node == nullptr) {
            return false;
        }

        if (node->val <= val) {
            return true;
        }

        return hasLowerEqual(node->left, val) || hasLowerEqual(node->right, val);
    }
};
