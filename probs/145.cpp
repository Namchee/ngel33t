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
    vector<int> postorderTraversal(TreeNode* root) {
        vector<int> path;

        traverse(root, path);
        return path;
    }

    void traverse(TreeNode* root, vector<int>& path) {
        if (root == nullptr) {
            return;
        }

        traverse(root->left, path);
        traverse(root->right, path);
        path.push_back(root->val);
    }
};