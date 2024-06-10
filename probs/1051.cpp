#include <vector>
#include <algorithm>
using namespace std;

class Solution
{
public:
    int heightChecker(vector<int> &heights)
    {
        vector<int> temp(heights.begin(), heights.end());
        sort(temp.begin(), temp.end());

        int count = 0;
        for (int i = 0; i < heights.size(); i++)
        {
            count += heights[i] != temp[i];
        }

        return count;
    }
};