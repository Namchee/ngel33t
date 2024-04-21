#include <vector>
using namespace std;

class Solution {
public:
    bool validPath(int n, vector<vector<int>>& edges, int source, int destination) {
        vector<vector<int> > adj(n, vector<int>());
        for (auto pr: edges) {
            adj[pr[0]].push_back(pr[1]);
            adj[pr[1]].push_back(pr[0]);
        }

        vector<bool> visit(n, false);
        traverse(adj, visit, source);

        return visit[destination];
    }

private:
    void traverse(vector<vector<int>>& edges, vector<bool>& visit, int n) {
        visit[n] = true;

        for (auto next: edges[n]) {
            if (!visit[next]) {
                traverse(edges, visit, next);
            }
        }
    }
};
