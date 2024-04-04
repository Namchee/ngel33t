#include <string>
#include <unordered_set>
#include <algorithm>
using namespace std;

class Solution {
public:
    bool closeStrings(string word1, string word2) {
        if (word1.length() != word2.length()) {
            return false;
        }
        
        int a[26] = { 0 };
        int b[26] = { 0 };

        unordered_set<char> st;

        for (char c: word1) {
            a[c - 'a']++;
            st.insert(c);
        }
        for (char c: word2) {
            b[c - 'a']++;

            if (st.find(c) == st.end()) {
                return false;
            } else {
                st.insert(c);
            }
        }

        sort(a, a + 26);
        sort(b, b + 26);

        for (int i = 0; i < 26; i++) {
            if (a[i] != b[i]) {
                return false;
            }
        }

        return true;
    }
};
