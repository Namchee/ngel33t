#include <iostream>
#include <cmath>
using namespace std;

int row[8];
int ways;

bool can_place(int r, int c)
{
    for (int col = 0; col < c; col++)
    {
        if (
            row[col] == r || // we have placed a queen in this column, no feasible
            abs(row[col] - r) == abs(col - c))
        {
            return false;
        }
    }

    return true;
}

void backtrack(int c)
{
    if (c == 8)
    {
        ways++;
        // print the solution perhaps?
    }

    for (int r = 0; r < 8; r++)
    {
        if (can_place(r, c))
        {
            row[c] = r;
            backtrack(c + 1);
        }
    }
}

// 8 queens, illustrates backtracking
//
// Time complexity: O(N!)
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    for (int i = 0; i < 8; i++)
    {
        row[i] = 0;
    }

    ways = 0;
    backtrack(0);

    cout << ways << "\n";
}