#include <iostream>
using namespace std;

// Coin change problem, how many ways to represent n amount with these denominator
//
// Time complexity: O(denom_count * target)
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int coins[] = {5, 10, 25};

    int target = 99; // say, I want to represent this amount with those denominators
    int ways[target + 1];

    ways[0] = 1; // there's only one way to represent nothing, by picking nothing!

    for (int idx = 0; idx < 3; idx++)
    {
        for (int c = coins[idx]; c <= target; c++)
        {
            ways[c] += ways[c - coins[idx]];
        }
    }

    return ways[target];
}