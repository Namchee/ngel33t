#include <vector>
#include <map>
using namespace std;

class Solution
{
public:
    bool isNStraightHand(vector<int> &hand, int groupSize)
    {
        map<int, int> mp;
        for (int card : hand)
        {
            mp[card]++;
        }

        for (auto &cards : mp)
        {
            while (mp[cards.first])
            {
                int curr = cards.first;

                for (int i = 0; i < groupSize - 1; i++)
                {
                    int p = curr + i + 1;

                    if (mp.find(p) == mp.end() || mp[p] == 0)
                    {
                        return false;
                    }

                    mp[p]--;
                }

                mp[cards.first]--;
            }
        }

        return true;
    }
};