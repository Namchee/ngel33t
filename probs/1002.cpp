#include <vector>
#include <string>
#include <climits>
using namespace std;

class Solution {
public:
    vector<string> commonChars(vector<string>& words) {
        int n = words.size();
        vector<vector<int> > freq(n, vector<int>(26, 0));

        for (int i = 0; i < n; i++) {
            for (char c: words[i]) {
                freq[i][c - 'a']++;
            }
        }

        vector<string> result;

        for (int i = 0; i < 26; i++) {
            int f = INT_MAX;

            for (int j = 0; j < n; j++) {
                f = min(f, freq[j][i]);
            }

            string str;
            str += (char)(i + 'a');

            while (f--) {
                result.push_back(str);
            }
        }
        
        return result;
    }
};
