#include <iostream>
#include <vector>
#include <queue>
#include <utility>
using namespace std;

#define INF 1000000000

int adj[10000][10000];

// Floyd-Warshall Algorithm
// All-pair shortest path
// Logic: `relax` the edges
// Time complexity: O(V^3)
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    for (int i = 0; i < 10000; i++)
    {
        for (int j = 0; j < 10000; j++)
        {
            adj[i][j] = INF; // let's say all of them are disconnected to each other
            if (i == j)
            {
                adj[i][j] = 0; // the distance to self is always zero
            }
        }
    }

    adj[0][1] = 5;
    adj[0][4] = 10;
    adj[1][2] = 3;
    adj[2][3] = 1;

    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            for (int k = 0; k < 4; k++)
            {
                if (adj[i][j] > (adj[i][k] + adj[k][j]) && adj[i][k] != INF && adj[k][j] != INF)
                {
                    adj[i][j] = adj[i][k] + adj[k][j];
                }
            }
        }
    }

    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            cout << i << "->" << j << ": " << adj[i][j] << "\n";
        }
    }
    return 0;
}