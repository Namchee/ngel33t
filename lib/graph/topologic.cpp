#include <vector>
#include <iostream>
#include <queue>
#include <unordered_map>
using namespace std;

vector<vector<int>> adj;
vector<bool> visited;

// Topological Sort
// Can be used to detect cycle too
//
// Time complexity: O(V + E)
// Space complexity: O(V), because of stack storing all vertices

// Cycle detection algorithm
vector<int> has_cycle()
{
    vector<int> in_degree(adj.size(), 0);

    for (int i = 0; i < adj.size(); i++)
    {
        for (auto to : adj[i])
        {
            in_degree[to]++;
        }
    }

    queue<int> q;
    for (int i = 0; i < adj.size(); i++)
    {
        if (in_degree[i] == 0)
        {
            q.push(i);
        }
    }

    vector<int> order;
    int count = 0;

    while (!q.empty())
    {
        int u = q.front();
        q.pop();
        order.push_back(u);

        for (int to : adj[u])
        {
            if (--in_degree[to] == 0)
            {
                q.push(to);
            }
        }

        count++;
    }

    if (count != adj.size()) {
        cout << "Cycle exist!" << endl;
    }

    return order;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int source = 0; // use this node as source

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
    }
}
