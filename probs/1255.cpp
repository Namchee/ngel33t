#include <vector>
#include <string>
#include <limits.h>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int maxScoreWords(vector<string>& words, vector<char>& letters, vector<int>& score) {
        unordered_map<char, int> mp;
        for (char c: letters) {
            mp[c]++;
        }

        w = words;
        s = score;
        result = INT_MIN;

        construct(0, 0, mp);

        return result;
    }

private:
    int result;
    vector<string> w;
    vector<int> s;

    void construct(int idx, int scr, unordered_map<char, int>& letters) {
        if (idx == w.size()) {
            result = max(result, scr);
        } else {
            if (isPickable(w[idx], letters)) {
                int acc = 0;
                for (char c: w[idx]) {
                    letters[c]--;
                    acc += s[c - 'a'];
                }

                construct(idx + 1, scr + acc, letters);
                for (char c: w[idx]) {
                    letters[c]++;
                }
            }

            construct(idx + 1, scr, letters);
        }
    }

    bool isPickable(string str, unordered_map<char, int> letters) {
        for (char c: str) {
            if (letters.find(c) == letters.end() || letters[c] <= 0) {
                return false;
            }

            letters[c]--;
        }

        return true;
    }
};
