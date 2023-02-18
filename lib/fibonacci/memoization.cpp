#include <iostream>
using namespace std;

// Fibonacci, with memos, obviously
// Time Complexity: O(n)
// Space Complexity: O(n)
int main()
{
    int n;

    cin >> n;

    int memo[n];
    memo[0] = 0;
    memo[1] = 1;

    for (int idx = 2; idx < n; idx++)
    {
        memo[idx] = memo[idx - 2] + memo[idx - 1];
    }

    cout << memo[n - 1];
}