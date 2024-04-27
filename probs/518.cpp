#include <vector>
using namespace std;

class Solution {
public:
    int change(int amount, vector<int>& coins) {
        vector<int> way(amount + 1, 0);
        way[0] = 1;

        for (int coin: coins) {
            for (int i = coin; i <= amount; i++) {
                way[i] += way[i - coin];
            }
        }

        return way[amount];
    }
};
