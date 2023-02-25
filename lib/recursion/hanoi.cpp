#include <iostream>
using namespace std;

void solve_hanoi(int n, int from, int to, int aux)
{
    if (n == 0)
    {
        return;
    }

    solve_hanoi(n - 1, from, aux, to);
    cout << "Move disk from " << from << " to " << to << "\n";
    solve_hanoi(n - 1, aux, to, from);
}

// Tower of Hanoi, our favorite recursion practice :)
//
// Time complexity: O(2 ^ n)
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    return 0;
}