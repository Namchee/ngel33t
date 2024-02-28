#include <vector>;
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
    vector<int> preorderTraversal(TreeNode* root) {
        vector<int> result;

        traverse(root, result);

        return result;
    }

    void traverse(TreeNode* root, vector<int>& path) {
        if (root == nullptr) {
            return;
        }

        path.push_back(root->val);
        traverse(root->left, path);
        traverse(root->right, path);
    }
};
