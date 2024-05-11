#include <vector>
#include <algorithm>
#include <queue>
#include <limits.h>
using namespace std;

class Solution {
public:
    double mincostToHireWorkers(vector<int>& quality, vector<int>& wage, int k) {
        vector<pair<double, int> > ratio;
        for (int i = 0; i < quality.size(); i++) {
            ratio.push_back({ wage[i] / (double)quality[i], quality[i] });
        }

        sort(ratio.begin(), ratio.end());
        priority_queue<int> pq;

        double result = INT_MAX;
        double sum = 0;

        for (int i = 0; i < quality.size(); i++) {
            pq.push(ratio[i].second);
            sum += ratio[i].second;
            if (pq.size() > k) {
                sum -= pq.top();
                pq.pop();
            }

            if (pq.size() == k) {
                result = min(result, sum * ratio[i].first);
            }
        }

        return result;
    }
};
