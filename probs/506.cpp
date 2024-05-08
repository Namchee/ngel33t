#include <string>
#include <vector>
#include <algorithm>
using namespace std;

class Solution
{
public:
    vector<string> findRelativeRanks(vector<int> &score)
    {
        vector<int> cpy = score;
        sort(cpy.begin(), cpy.end(), std::greater<int>());

        unordered_map<int, int> mp;
        for (int i = 0; i < score.size(); i++)
        {
            mp[cpy[i]] = i + 1;
        }

        vector<string> result(score.size(), "");
        for (int i = 0; i < score.size(); i++)
        {
            int pos = mp[score[i]];

            if (pos == 1)
            {
                result[i] = "Gold Medal";
            }
            else if (pos == 2)
            {
                result[i] = "Silver Medal";
            }
            else if (pos == 3)
            {
                result[i] = "Bronze Medal";
            }
            else
            {
                result[i] = to_string(pos);
            }
        }

        return result;
    }
};