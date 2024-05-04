#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int numRescueBoats(vector<int>& people, int limit) {
        sort(people.begin(), people.end());
        int result = 0;

        for (int l = 0, r = people.size() - 1; l <= r; r--) {
            result++;
            if (people[l] <= limit - people[r]) {
                l++;
            }
        }

        return result;
    }
};
