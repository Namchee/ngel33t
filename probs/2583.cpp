#include <map>;
#include <algorithm>;
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
    long long kthLargestLevelSum(TreeNode* root, int k) {
        unordered_map<int, long long> mp;

        visit(root, mp, 0);
        vector<long long> sums;
        for (auto it: mp) {
            sums.push_back(it.second);
        }

        sort(sums.begin(), sums.end(), greater<long long>());

        return k <= sums.size() ? sums[k - 1] : -1;
    }

    void visit(TreeNode* root, unordered_map<int, long long>& mp, int depth) {
        if (root == nullptr) {
            return;
        }

        mp[depth] += root->val;

        visit(root->left, mp, depth + 1);
        visit(root->right, mp, depth + 1);
    }
};
