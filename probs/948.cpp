#include <vector>;
using namespace std;

class Solution {
public:
    int bagOfTokensScore(vector<int>& tokens, int power) {
        sort(tokens.begin(), tokens.end());

        int l = 0;
        int r = tokens.size() - 1;

        int curr = 0;
        int best = 0;

        while (l <= r) {
            bool picked = false;
            if (power >= tokens[l]) {
                power -= tokens[l];
                curr++;
                l++;
                picked = true;
            }

            best = max(curr, best);

            if (curr > 0 && l < tokens.size() && power < tokens[l]) {
                power += tokens[r];
                curr--;
                r--;
                picked = true;
            }

            best = max(curr, best);
            if (!picked) {
                break;
            }
        }

        return best;
    }
};