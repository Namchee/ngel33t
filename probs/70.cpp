#include <iostream>

using namespace std;

int climbStairs(int n)
{
    int ways[n + 1];
    for (int i = 0; i <= n; i++)
    {
        ways[i] = 0;
    }
    ways[0] = 1;

    for (int i = 1; i <= n; i++)
    {
        ways[i] += ways[i - 1];
        if (i > 1)
        {
            ways[i] += ways[i - 2];
        }
    }

    return ways[n];
}

int main()
{
    int n;
    cin >> n;

    cout << climbStairs(n) << endl;
}