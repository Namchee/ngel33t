#include <string>
#include <vector>
using namespace std;

class Solution {
public:
    string removeKdigits(string num, int k) {
        if (k == num.length()) {
            return "0";
        }

        vector<char> stk;

        for (int i = 0; i < num.length(); i++) {
            while (k && !stk.empty() && num[i] < stk.back()) {
                k--;
                stk.pop_back();
            }

            stk.push_back(num[i]);
        }
        while (k > 0) {
            stk.pop_back();
            k--;
        }

        int idx = 0;
        while (idx < stk.size()) {
            if (stk[idx] != '0') {
                break;
            }

            idx++;
        }

        string ans(stk.begin() + idx, stk.end());

        return ans == "" ? "0" : ans;

        return ans;
    }
};
