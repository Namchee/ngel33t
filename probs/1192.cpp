#include <vector>
using namespace std;

class Solution {
public:
    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        vector<vector<int> > adj(n);

        for (int i = 0; i < connections.size(); i++) {
            int a = connections[i][0];
            int b = connections[i][1];

            adj[a].push_back(b);
            adj[b].push_back(a);
        }

        find_bridges(adj);

        return result;
    }
private:
    vector<bool> visited;
    vector<int> hist;
    vector<int> low;
    vector<vector<int> > result;

    int timer;

    void visit(vector<vector<int> >& adj, int v, int src = -1) {
        visited[v] = true;
        hist[v] = low[v] = timer++;

        for (int to: adj[v]) {
            if (to == src) {
                continue;
            }

            if (visited[to]) {
                low[v] = min(low[v], hist[to]);
            } else {
                visit(adj, to, v);
                low[v] = min(low[v], low[to]);
                if (low[to] > hist[v]) {
                    result.push_back({ v, to });
                }
            }
        }
    }

    void find_bridges(vector<vector<int> >& adj) {
        timer = 0;
        visited.assign(adj.size(), false);
        hist.assign(adj.size(), -1);
        low.assign(adj.size(), -1);

        for (int i = 0; i < adj.size(); i++) {
            if (!visited[i]) {
                visit(adj, i);
            }
        }
    }
};
