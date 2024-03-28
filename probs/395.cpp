#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    int longestSubstring(string s, int k) {
        int result = 0;
        int n = s.size();
        vector<vector<int> > freq(n, vector<int>(26, 0));
        for (int i = 0; i < n; i++) {
            freq[i][s[i] - 'a']++;

            if (i > 0) {
                for (int j = 0; j < 26; j++) {
                    freq[i][j] += freq[i - 1][j];
                }
            }

            if (isAtLeastK(freq[i], k)) {
                result = max(result, i + 1);
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            for (int j = 0; j < i; j++) {
                freq[i][s[j] - 'a']--;

                if (isAtLeastK(freq[i], k)) {
                    result = max(result, i - j);
                    break;
                }
            }
        }

        return result;
    }

private:
    bool isAtLeastK(vector<int>& freq, int k) {
        for (int num: freq) {
            if (num && num < k) {
                return false;
            }
        }

        return true;
    }
};
