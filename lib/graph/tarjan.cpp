// Tarjan algorithm, find edges that are bridge. A bridge is an edge
// which when removed makes the graph disconnected.
//
// Complexity: O(edge + node)
#include <vector>;
#include <stdio.h>;
using namespace std;

int n; // number of nodes
vector<vector<int> > adj;

vector<bool> visited;
vector<int> hist, low;
int timer;

void dfs(int v, int p = -1) {
    visited[v] = true;
    hist[v] = low[v] = timer++;
    for (int to: adj[v]) {
        if (to == p) { // no self loop
            continue;
        }

        if (visited[to]) {
            low[v] = min(low[v], hist[to]);
        } else {
            dfs(to, v);
            low[v] = min(low[v], low[to]);
            if (low[to] > hist[v]) {
                printf("Edge %d %d is a bridge!\n", v, to);
            }
        }
    }
}

void find_bridges() {
    timer = 0;
    visited.assign(n, false);
    hist.assign(n, -1);
    low.assign(n, -1);

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
        }
    }
}
