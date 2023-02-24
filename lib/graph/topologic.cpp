#include <vector>
#include <iostream>
#include <stack>
#include <unordered_map>
using namespace std;

vector<vector<int>> adj;
vector<bool> visited;
stack<int> order;

// Topological Sort, not Topologic Gumblar Dragon
// Can be used to detect cycle too
//
// Time complexity: O(V + E)
// Space complexity: O(V), because of stack storing all vertices

void dfs(int node)
{
    if (visited[node])
    {
        return;
    }

    visited[node] = true;
    for (int idx = 0; idx < adj[node].size(); idx++)
    {
        if (!visited[adj[node][idx]])
        {
            dfs(adj[node][idx]);
        }
    }

    order.push(node);
}

// Cycle detection algorithm
bool has_cycle()
{
    unordered_map<int, int> pos;
    int ord = 0;

    while (!order.empty())
    {
        pos[order.top()] = ord++;
        order.pop();
    }

    for (int idx = 0; idx < (int)adj.size(); idx++)
    {
        for (int j = 0; j < adj[idx].size(); j++)
        {
            if (pos[adj[idx][j]] < pos[idx])
            {
                return true; // if the parent doesn't appear first, there's a cycle
            }
        }
    }

    return false;
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

    dfs(source);

    while (!order.empty())
    {
        cout << order.top() << " ";
        order.pop();
    }
}