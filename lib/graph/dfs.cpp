#include <vector>
#include <iostream>
using namespace std;

vector<vector<int>> adj;
vector<bool> visited;

// DFS Algorithm
// Time complexity: O(V + E)
// Space complexity: O(V + E), because adjacency list

void dfs(int node)
{
    if (visited[node])
    {
        return;
    }

    cout << node << "\n";
    visited[node] = true;
    for (int idx = 0; idx < adj[node].size(); idx++)
    {
        if (!visited[adj[node][idx]])
        {
            dfs(adj[node][idx]);
        }
    }
}

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

    dfs(0);
}