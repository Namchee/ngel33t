#include <unordered_set>
#include <string>
using namespace std;

int lengthOfLongestSubstring(string s)
{
    unordered_set<char> lkp;

    int start = 0;
    int best = 0;

    for (int i = 0; i < s.length(); i++)
    {
        if (lkp.find(s[i]) != lkp.end())
        {
            best = max(best, i - start);

            while (lkp.find(s[i]) != lkp.end())
            {
                lkp.erase(s[start]);
                start++;
            }
        }

        lkp.insert(s[i]);
    }

    return max(best, (int)s.length() - start);
}