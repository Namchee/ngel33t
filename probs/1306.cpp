#include <queue>
#include <vector>
using namespace std;

class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        queue<pair<int, int> > q;
        q.push({ start, 0 });

        vector<bool> visited(arr.size(), false);

        while (!q.empty()) {
            pair<int, int> p = q.front();
            q.pop();

            int pos = p.first;
            int count = p.second;

            visited[pos] = true;

            if (arr[pos] == 0) {
                return true;
            }

            int a = pos + arr[pos];
            int b = pos - arr[pos];

            if (a >= 0 && a < arr.size() && !visited[a]) {
                q.push({ a, count + 1 });
            }

            if (b >= 0 && b < arr.size() && !visited[b]) {
                q.push({ b, count + 1 });
            }
        }

        return false;
    }
};
