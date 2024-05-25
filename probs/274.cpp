#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int hIndex(vector<int>& citations) {
        sort(citations.begin(), citations.end());
        int n = citations.size();
        int lo = 0;
        int hi = citations.size() - 1;
        int result = 0;

        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            int idx = n - mid;

            if (citations[mid] >= idx) {
                result = idx;
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }

        return result;
    }
};
