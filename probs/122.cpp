#include <vector>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        vector<int> profits(prices.size(), 0);

        for (int i = 1; i < prices.size(); i++) {
            if (prices[i] > prices[i - 1]) {
                profits[i] += profits[i - 1] + (prices[i] - prices[i - 1]);
            } else {
                profits[i] = profits[i - 1];
            }
        }

        return profits[prices.size() - 1];
    }
};
