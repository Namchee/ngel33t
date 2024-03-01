#include <string>;
using namespace std;

class Solution {
public:
    string maximumOddBinaryNumber(string s) {
        int freq = 0;
        for (int i = 0; i < s.size(); i++) {
            freq += s[i] == '1';
        }

        string res;

        for (int i = 0; i < s.size() - 1; i++) {
            if (freq > 1) {
                res += '1';
                freq--;
            }  else {
                res += '0';
            }
        }

        return res + '1';
    }
};
