#include <vector>
#include <unordered_map>
using namespace std;

int majorityElement(vector<int> &nums)
{
    unordered_map<int, int> mp;
    for (int i = 0; i < nums.size(); i++)
    {
        mp[nums[i]]++;
    }

    int best = 0;
    int freq = 0;

    for (auto it : mp)
    {
        if (it.second > freq)
        {
            best = it.first;
            freq = it.second;
        }
    }

    return best;
}