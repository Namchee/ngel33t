#include <vector>
#include <iostream>
#include <string>
using namespace std;

int maxProfit(vector<int> &prices)
{
    vector<int> best(prices.size(), 1000000000);

    int result = 0;
    for (int i = 1; i < best.size(); i++)
    {
        best[i] = min(prices[i - 1], best[i - 1]);

        result = max(result, prices[i] - best[i]);
    }

    return result;
}