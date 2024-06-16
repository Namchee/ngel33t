#include <vector>
#include <unordered_map>
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
    vector<int> rightSideView(TreeNode *root)
    {
        unordered_map<int, vector<int>> mp;
        traverse(root, 0, mp);

        vector<int> result;
        for (int i = 0; i < mp.size(); i++)
        {
            result.push_back(mp[i].back());
        }

        return result;
    }

private:
    void traverse(TreeNode *curr, int level, unordered_map<int, vector<int>> &mp)
    {
        if (!curr)
        {
            return;
        }

        traverse(curr->left, level + 1, mp);
        mp[level].push_back(curr->val);
        traverse(curr->right, level + 1, mp);
    }
};
