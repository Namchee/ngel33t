#include <string>
#include <unordered_map>
using namespace std;

class Solution
{
public:
    string minWindow(string s, string t)
    {
        if (t.length() > s.length())
        {
            return "";
        }

        int start = 0;
        int end = 0;

        string result = "";

        unordered_map<char, int> mp, curr;
        for (char c : t)
        {
            mp[c]++;
        }

        while (end < s.size())
        {
            curr[s[end]]++;
            if (isSatisfied(mp, curr))
            {
                int len = end - start + 1;
                while (isSatisfied(mp, curr))
                {
                    curr[s[start++]]--;
                    len--;
                }

                if (len < result.length() || result.length() == 0)
                {
                    result = s.substr(start > 0 ? start - 1 : 0, len + 1);
                }
            }

            end++;
        }

        return result;
    }

private:
    bool isSatisfied(unordered_map<char, int> &a, unordered_map<char, int> &b)
    {
        for (auto entry : a)
        {
            if (b.find(entry.first) == b.end() || b[entry.first] < entry.second)
            {
                return false;
            }
        }

        return true;
    }
};
