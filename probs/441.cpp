#include <cmath>
using namespace std;

int arrangeCoins(int n)
{
    int x = 1;
    int best = 0;

    while (((x + pow(x, 2)) / 2) <= n)
    {
        best = x;
        x++;
    }

    return best;
}