#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    int longestIdealString(string s, int k) {
        int result = 1;
        vector<int> table(26, 0);

        for (char c: s) {
            int idx = c - 'a';
            for (int j = idx; j >= 0 && j >= idx - k; j--) {
                table[idx] = max(table[idx], table[j] + 1);
            }
            for (int j = idx + 1; j < 26 && j <= idx + k; j++) {
                table[idx] = max(table[idx], table[j] + 1);
            }

            result = max(result, table[idx]);
        }

        return result;
    }
};