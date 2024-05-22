#include <string>
#include <vector>
using namespace std;

class Solution
{
public:
    bool isPalindrome(string str)
    {
        int n = str.size();
        for (int i = 0; i < n / 2; i++)
        {
            if (str[i] != str[n - 1 - i])
            {
                return false;
            }
        }

        return true;
    }

    vector<vector<string>> ans;

    void backtrack(vector<string> &cur, string s, int idx)
    {
        if (idx == s.length())
        {
            ans.push_back(cur);
        }
        else
        {
            for (int i = idx; i < s.length(); i++)
            {
                if (isPalindrome(s.substr(idx, i - idx + 1)))
                {
                    cur.push_back(s.substr(idx, i - idx + 1));
                    backtrack(cur, s, i + 1);
                    cur.pop_back();
                }
            }
        }
    }

    vector<vector<string>> partition(string s)
    {
        vector<string> cur;
        backtrack(cur, s, 0);

        return ans;
    }
};
