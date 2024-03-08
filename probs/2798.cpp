#include <vector>;
using namespace std;

class Solution {
public:
    long long maxArrayValue(vector<int>& nums) {
        long long best = 0;
        int n = nums.size();

        vector<long long> arr(n);
        for (int i = 0; i < n; i++) {
            arr[i] = nums[i];
        }

        for (int i = 0; i < n; i++) {
            best = max(best, arr[i]);
        }

        for (int i = n - 1; i >= 0; i--) {
            if (i - 1 >= 0 && arr[i] >= arr[i - 1]) {
                arr[i - 1] += arr[i];
                arr[i] = 0;
                best = max(best, arr[i - 1]);
            }
        }

        return best;
    }
};
