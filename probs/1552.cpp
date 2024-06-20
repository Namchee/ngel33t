#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxDistance(vector<int>& position, int m) {
        sort(position.begin(), position.end());

        int start = 0;
        int end = 0;
        for (int pos: position) {
            end = max(end, pos);
        }

        int maxi = 0;
        while (start <= end) {
            int mid = start + (end - start) / 2;
            if (possible(position, m, mid)) {
                maxi = mid;
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }

        return maxi;
    }

private:
    bool possible(vector<int>& position, int balls, int range) {
        int now = 1;
        int last = position[0];
        for (int i = 1; i < position.size(); i++) {
            if (position[i] - last >= range) {
                now++;
                last = position[i];
            }
        }

        return now >= balls;
    }
};
