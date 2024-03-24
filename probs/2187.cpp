#include <vector>
#include <climits>
using namespace std;

class Solution {
public:
    long long minimumTime(vector<int>& time, int totalTrips) {
        long long lo = 0;
        long long hi = 0;

        int mini = INT_MAX;
        for (int num: time) {
            mini = min(num, mini);
        }

        hi = (long long)mini * (long long)totalTrips;

        while (lo <= hi) {
            long long mid = lo + (hi - lo) / 2;
            long long trips = 0;

            for (int i = 0 ; i < time.size(); i++) {
                trips += mid / time[i];
            }

            if (trips >= totalTrips) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }

        return lo + (hi - lo) / 2;
    }
};
