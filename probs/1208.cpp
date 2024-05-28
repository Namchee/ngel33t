#include <string>
using namespace std;

class Solution {
public:
    int equalSubstring(string s, string t, int maxCost) {
        int start = 0;
        int end = 0;

        int result = 0;
        int cost = 0;

        while (end < t.length()) {
            cost += abs(s[end] - t[end]);
            while (cost > maxCost) {
                cost -= abs(s[start] - t[start]);
                start++;
            }

            result = max(result, end - start + 1);
            end++;
        }

        return result;
    }
};
