#include <vector>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        // three states:
        // 1. Max profit if we have one stock left
        // 2. Max profit if we have no stock left
        // 3. Cooldown state
        int n = prices.size();
        vector<vector<int> > table(n, vector<int>(3, 0));
        // buy the first stock
        table[0][0] = -prices[0];

        for (int i = 1; i < n; i++) {
            // max of prev state, or buy this stock on cooldown
            table[i][0] = max(table[i - 1][0], table[i - 1][2] - prices[i]);
            // max of prev state, or sell the stock
            table[i][1] = max(table[i - 1][1], table[i - 1][0] + prices[i]);
            // cooldown
            table[i][2] = table[i - 1][1];
        }

        return max(table[n - 1][1], table[n - 1][2]);
    }
};
