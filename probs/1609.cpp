#include <map>;
using namespace std;

class Solution {
public:
    bool isEvenOddTree(TreeNode* root) {
        unordered_map<int, vector<int> > mp;

        traverse(root, mp, 0);

        for (auto it: mp) {
            int depth = it.first;
            vector<int> members = it.second;

            if (depth % 2 == 0) {
                for (int i = 0; i < members.size(); i++) {
                    if (members[i] % 2 == 0) {
                        return false;
                    }

                    if (i > 0 && members[i] <= members[i - 1]) {
                        return false;
                    }
                }
            } else {
                for (int i = 0; i < members.size(); i++) {
                    if (members[i] % 2 != 0) {
                        return false;
                    }

                    if (i > 0 && members[i] >= members[i - 1]) {
                        return false;
                    }
                }
            }
        }

        return true;
    }

    void traverse(TreeNode* node, unordered_map<int, vector<int> >& mp, int depth) {
        if (node == nullptr) {
            return;
        }

        mp[depth].push_back(node->val);
        traverse(node->left, mp, depth + 1);
        traverse(node->right, mp, depth + 1);
    }
};