#include <vector>
#include <algorithm>
#include <queue>
using namespace std;

class Solution {
public:
    int findMaximizedCapital(int k, int w, vector<int>& profits, vector<int>& capital) {
        vector<pair<int, int> > pairs;
        int n = profits.size();

        for (int i = 0; i < n; i++) {
            pairs.push_back({ capital[i], profits[i] });
        }

        sort(pairs.begin(), pairs.end());
        priority_queue<int> pq;

        int j = 0;

        for (int i = 0; i < k; i++) {
            for (; j < n && pairs[j].first <= w; j++) {
                pq.push(pairs[j].second);
            }

            if (!pq.empty()) {
                w += pq.top();
                pq.pop();
            } else {
                break;
            }
        }

        return w;
    }
};
