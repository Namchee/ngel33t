#include <string>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int takeCharacters(string s, int k) {
        if (k == 0) {
            return 0;
        }

        unordered_map<int, int> mpA, mpB, mpC;

        int best = -1;

        int a = 0;
        int b = 0;
        int c = 0;
        for (int i = 0; i < s.size(); i++) {
            a += s[i] == 'a';
            b += s[i] == 'b';
            c += s[i] == 'c';

            if (a >= k && b >= k && c >= k && (best == -1 || i + 1 < best)) {
                best = i + 1;
            }

            if (mpA.find(a) == mpA.end()) {
                mpA[a] = i;
            }

            if (mpB.find(b) == mpB.end()) {
                mpB[b] = i;
            }

            if (mpC.find(c) == mpC.end()) {
                mpC[c] = i;
            }
        }

        if (a < k || b < k || c < k) {
            return best;
        }

        a = 0;
        b = 0;
        c = 0;

        for (int i = s.size() - 1; i >= 0; i--) {
            a += s[i] == 'a';
            b += s[i] == 'b';
            c += s[i] == 'c';

            if (a >= k && b >= k && c >= k && (best == -1 || (s.size() - i) < best)) {
                best = s.size() - i;
            }

            int posA = mpA[k - a];
            int posB = mpB[k - b];
            int posC = mpC[k - c];

            int len = (max(posA, max(posB, posC)) + 1) + s.size() - i;

            if (best == -1 || len < best) {
                best = len;
            }
        }

        return best;
    }
};
