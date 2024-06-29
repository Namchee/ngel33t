#include <vector>
#include <queue>
#include <bitset>
using namespace std;

class Solution {
public:
    vector<vector<int>> getAncestors(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        vector<int> in_degree(n, 0);
        vector<bitset<1000>> ancestors(n);

        for (const vector<int>& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            in_degree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            for (int neighbor : adj[curr]) {
                ancestors[neighbor][curr] = 1;
                ancestors[neighbor] |= ancestors[curr];

                if (--in_degree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        vector<vector<int>> res(n);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (ancestors[i][j]) {
                    res[i].push_back(j);
                }
            }
        }

        return res;
    }
};

