#include <vector>
#include <queue>
#include <set>
using namespace std;

class Solution {
public:
    vector<vector<int>> getAncestors(int n, vector<vector<int>>& edges) {
        vector<vector<int> > adj(n, vector<int>());
        vector<int> in_degree(n, 0);
        vector<set<int> > result(n, set<int>());

        for (vector<int>& edge: edges) {
            adj[edge[0]].push_back(edge[1]);
            in_degree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; i++) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            for (int adj: adj[curr]) {
                for (int n: result[curr]) {
                    result[adj].insert(n);
                }

                result[adj].insert(curr);
                in_degree[adj]--;

                if (in_degree[adj] <= 0) {
                    q.push(adj);
                }
            }
        }

        vector<vector<int> > res(n, vector<int>());
        for (int i = 0; i < n; i++) {
            for (int num: result[i]) {
                res[i].push_back(num);
            }
        }

        return res;
    }
};
