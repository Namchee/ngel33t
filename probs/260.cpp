#include <vector>
using namespace std;

class Solution
{
public:
    vector<int> singleNumber(vector<int> &nums)
    {
        long long exor = 0;
        for (int num : nums)
        {
            exor ^= num;
        }

        int lastBit = exor ^ (exor & (exor - 1));
        int a = 0;
        int b = 0;

        for (int num : nums)
        {
            if ((num & lastBit) == 0)
            {
                a ^= num;
            }
            else
            {
                b ^= num;
            }
        }

        return {a, b};
    }
};
