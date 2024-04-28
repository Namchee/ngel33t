#include <vector>
using namespace std;

class Solution {
public:
    vector<int> sumOfDistancesInTree(int n, vector<vector<int>>& edges) {
        adj = vector<vector<int> >(n, vector<int>());
        count = vector<int>(n, 1);
        res = vector<int>(n, 0);

        for (auto edge: edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        dfs(0, -1);
        dfs2(0, -1);

        return res;
    }

private:
    vector<vector<int> > adj;
    vector<int> count, res;

    void dfs(int node, int parent) {
        for (int child: adj[node]) {
            if (child != parent) {
                dfs(child, node);
                count[node] += count[child];
                res[node] += res[child] + count[child];
            }
        }
    }

    void dfs2(int node, int parent) {
        for (int child: adj[node]) {
            if (child != parent) {
                res[child] = res[node] - count[child] + (count.size() - count[child]);
                dfs2(child, node);
            }
        }
    }
};
