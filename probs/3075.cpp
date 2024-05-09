#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    long long maximumHappinessSum(vector<int>& happiness, int k) {
        sort(happiness.begin(), happiness.end(), std::greater<int>());

        unsigned long long result = 0;
        int pass = 0;

        while (k--) {
            if (happiness[pass] >= pass) {
                result += happiness[pass] - pass;
            }
            
            pass++;
        }

        return result;
    }
};
