#include <vector>
#include <map>
#include <iostream>
using namespace std;

vector<int> twoSum(vector<int> &nums, int target)
{
    map<int, int> mp;

    for (int i = 0; i < nums.size(); i++)
    {
        mp[nums[i]] = i;
    }

    for (int i = 0; i < nums.size(); i++)
    {
        int t = target - nums[i];

        if (mp.find(t) != mp.end() && mp[t] != i)
        {
            return {i, mp[t]};
        }
    }

    return {};
}

int main()
{
    vector<int> vec = {3, 2, 4};

    vector<int> result = twoSum(vec, 6);

    cout << result[0] << " " << result[1] << "\n";

    return 0;
}
