#include <vector>;
#include <queue>;
using namespace std;

class Solution {
public:
    bool canFinish(int numCourses, vector<vector<int>>& prerequisites) {
        if (prerequisites.size() == 0) {
            return true;
        }

        adj.assign(numCourses, vector<int>());

        for (int i = 0; i < prerequisites.size(); i++) {
            int a = prerequisites[i][0];
            int b = prerequisites[i][1];

            adj[b].push_back(a);
        }

        return !has_cycle();
    }

private:
    vector<vector<int> > adj;

    bool has_cycle() {
        vector<int> in_degree(adj.size(), 0);

        for (int i = 0; i < adj.size(); i++) {
            for (auto to: adj[i]) {
                in_degree[to]++;
            }
        }

        queue<int> q;
        for (int i = 0; i < adj.size(); i++) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        int count = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int to: adj[u]) {
                if (--in_degree[to] == 0) {
                    q.push(to);
                }
            }

            count++;
        }

        return count != adj.size();
    }
};
