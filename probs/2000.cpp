#include <string>
using namespace std;

class Solution {
public:
    string reversePrefix(string word, char ch) {
        int idx = 0;
        while (idx < word.length()) {
            if (word[idx] == ch) {
                break;
            }

            idx++;
        }

        if (idx == word.length()) {
            return word;
        }

        string res;
        int cp = idx;
        while (cp >= 0) {
            res += word[cp--];
        }

        idx++;
        while (idx < word.length()) {
            res += word[idx++];
        }

        return res;
    }
};
