#include <vector>
#include <set>
using namespace std;

vector<vector<int>> threeSum(vector<int> &nums)
{
    set<vector<int>> prs;

    sort(nums.begin(), nums.end());

    for (int i = 0; i < nums.size() - 2; i++)
    {
        int j = i + 1;
        int k = nums.size() - 1;

        while (j < k)
        {
            int sum = nums[i] + nums[j] + nums[k];
            if (sum == 0)
            {
                prs.insert({nums[i], nums[j], nums[k]});
                j++;
                k--;
            }
            else if (sum > 0)
            {
                k--;
            }
            else
            {
                j++;
            }
        }
    }

    vector<vector<int>> result;
    for (auto vec : prs)
    {
        result.push_back(vec);
    }

    return result;
}