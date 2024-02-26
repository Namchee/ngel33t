#include <string>;
using namespace std;

class Solution {
public:
    string longestPalindrome(string s) {
        int start = 0;
        int len = 0;

        for (int i = 0; i < s.size(); i++) {
            int l = i;
            int r = i;

            while (l >= 0 && r < s.size() && s[l] == s[r]) {
                l--;
                r++;
            }

            if (r - l - 1 > len) {
                start = l + 1;
                len = r - l - 1;
            }

            l = i;
            r = i + 1;

            while (l >= 0 && r < s.size() && s[l] == s[r]) {
                l--;
                r++;
            }

            if (r - l - 1 > len) {
                start = l + 1;
                len = r - l - 1;
            }
        }

        return s.substr(start, len);
    }
};
