#include <vector>
using namespace std;

int coinChange(vector<int> &coins, int amount)
{
    vector<int> mm(amount + 1, 1000000000);
    mm[0] = 0;

    for (int i = 1; i <= amount; i++)
    {
        for (int j = 0; j < coins.size(); j++)
        {
            if (coins[j] <= i)
            {
                mm[i] = min(mm[i], mm[i - coins[j]] + 1);
            }
        }
    }

    if (mm[amount] == 1000000000)
    {
        return -1;
    }

    return mm[amount];
}