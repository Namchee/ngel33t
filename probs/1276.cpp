#include <vector>;
using namespace std;

class Solution {
public:
    vector<int> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        if (tomatoSlices & 1 || cheeseSlices > 2 * tomatoSlices) {
            return {};
        }

        int big = (tomatoSlices / 2) - cheeseSlices;
        int small = cheeseSlices - big;

        if (big < 0 || small < 0) {
            return {};
        }

        return { big, small };
    }
};
