#include <vector>;
#include <map>;
#include <algorithm>;
using namespace std;

class Solution {
public:
    vector<int> dailyTemperatures(vector<int>& temperatures) {
        vector<int> days(temperatures.size(), 0);

        map<int, int> stack;

        for (int i = temperatures.size() - 1; i >= 0; i--) {
            int best = temperatures.size() + 1;

            for (auto& [temp, idx]: stack) {
                if (temp > temperatures[i]) {
                    best = min(best, idx - i);
                }
            }

            if (best == temperatures.size() + 1) {
                days[i] = 0;
            } else {
                days[i] = best;
            }

            stack[temperatures[i]] = i;
        }

        return days;
    }
};
