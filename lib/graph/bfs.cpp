#include <vector>
#include <queue>
#include <iostream>
using namespace std;

vector<vector<int>> adj;
vector<bool> visited;

// BFS Algorithm
// Time complexity: O(V + E)
// Space complexity: O(V + E), because adjacency list
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int size, a, b;
    cin >> size;

    adj.resize(size, vector<int>());
    visited.resize(size, false);

    while (true)
    {
        cin >> a >> b;

        if (a == 0 || b == 0)
        {
            break;
        }

        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    queue<int> q;
    q.push(0);

    while (!q.empty())
    {
        int curr = q.front();
        q.pop();

        if (visited[curr])
        {
            continue;
        }

        cout << curr << "\n";
        visited[curr] = true;

        for (int idx = 0; idx < adj[curr].size(); idx++)
        {
            if (!visited[adj[curr][idx]])
            {
                q.push(adj[curr][idx]);
            }
        }
    }
}