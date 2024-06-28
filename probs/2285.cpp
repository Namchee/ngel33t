#include <vector>
#include <unordered_map>
#include <queue>
using namespace std;

class Solution {
public:
    long long maximumImportance(int n, vector<vector<int>>& roads) {
        vector<int> connection(n, 0);

        for (int i = 0; i < roads.size(); i++) {
            vector<int> conn = roads[i];

            connection[conn[0]]++;
            connection[conn[1]]++;
        }

        unordered_map<int, int> value;
        priority_queue<pair<int, int> > pq;

        for (int i = 0; i < n; i++) {
            pq.push({ connection[i], i });
        }

        int val = n;

        while (!pq.empty()) {
            value[pq.top().second] = val--;
            pq.pop();
        }

        long long result = 0;
        for (int i = 0; i < roads.size(); i++) {
            vector<int> conn = roads[i];

            result += (long long)value[conn[0]] + (long long)value[conn[1]];
        }

        return result;
    }
};
