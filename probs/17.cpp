#include <vector>
#include <string>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<string> letterCombinations(string digits) {
        vector<string> result;

        if (digits.size() > 0) {
            generate(digits, 0, "", result);
        }


        return result;
    }

private:
    unordered_map<char, string> mp = {
        {'2', "abc"},
        {'3', "def"},
        {'4', "ghi"},
        {'5', "jkl"},
        {'6', "mno"},
        {'7', "pqrs"},
        {'8', "tuv"},
        {'9', "wxyz"},
    };

    void generate(string digits, int idx, string curr, vector<string>& result) {
        if (idx == digits.size()) {
            result.push_back(curr);
        } else {
            for (int i = 0; i < mp[digits[idx]].size(); i++) {
                generate(digits, idx + 1,  curr + mp[digits[idx]][i], result);
            }
        }
    }
};
