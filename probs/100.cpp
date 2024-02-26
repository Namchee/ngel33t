#include <vector>;
#include <climits>;
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
    bool isSameTree(TreeNode* p, TreeNode* q) {
        vector<int> a;
        vector<int> b;

        traverse(p, a);
        traverse(q, b);

        if (a.size() != b.size()) {
            return false;
        }

        for (int i = 0; i < a.size(); i++) {
            if (a[i] != b[i]) { 
                return false;
            }
        }

        return true;
    }

    void traverse(TreeNode* curr, vector<int>& ref) {
        if (curr == nullptr) {
            ref.push_back(INT_MIN);
        } else {
            ref.push_back(curr->val);

            traverse(curr->left, ref);
            traverse(curr->right, ref);
        }
    }
};
