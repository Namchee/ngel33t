class Solution {
public:
    vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
        vector<vector<int> > adj(numCourses, vector<int>());
        vector<int> in_degree(numCourses);

        for (int i = 0; i < prerequisites.size(); i++) {
            int a = prerequisites[i][0];
            int b = prerequisites[i][1];
            
            in_degree[a]++;
            adj[b].push_back(a);
        }

        queue<int> q;
        vector<int> order;

        for (int i = 0; i < numCourses; i++) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            order.push_back(curr);

            for (int to: adj[curr]) {
                if (--in_degree[to] == 0) {
                    q.push(to);
                }
            }
        }

        return order.size() != numCourses ? vector<int>() : order;
    }
};