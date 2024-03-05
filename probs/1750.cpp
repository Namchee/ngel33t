#include <string>;
using namespace std;

class Solution {
public:
    int minimumLength(string s) {
        int l = 0;
        int r = s.size() - 1;

        while (l <= r && l < s.size() && r >= 0) {
            char curr = s[l];

            if (s[l] != s[r] || r == l) {
                break;
            }

            while (l < s.size() && s[l] == curr) {
                l++;
            }

            while (r >= 0 && s[r] == curr) {
                r--;
            }
        }

        if (l > r) {
            return 0;
        }

        return r - l + 1;
    }
};
