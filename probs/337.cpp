#include <unordered_map>;
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int rob(TreeNode* root) {
        unordered_map<TreeNode*, int> mp;

        return traverse(root, mp);
    }

    int traverse(TreeNode* node, unordered_map<TreeNode*, int>& mp) {
        if (node == nullptr) {
            return 0;
        }

        if (mp.find(node) != mp.end()) {
            return mp[node];
        }

        int ans = node->val;

        if (node->left) {
            ans += traverse(node->left->left, mp) + traverse(node->left->right, mp);
        }

        if (node->right) {
            ans += traverse(node->right->left, mp) + traverse(node->right->right, mp);
        }

        ans = max(ans, traverse(node->left, mp) + traverse(node->right, mp));
        mp[node] = ans;

        return mp[node];
    }
};
