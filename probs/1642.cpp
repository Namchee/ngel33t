#include <queue>
#include <vector>
using namespace std;

class Solution {
public:
    int furthestBuilding(vector<int>& heights, int bricks, int ladders) {
        priority_queue<int, vector<int>, greater<int> > pq;

        for (int idx = 0; idx < heights.size() - 1; idx++) {
            int diff = heights[idx + 1] - heights[idx];
            if (diff > 0) {
                if (pq.size() < ladders) {
                    pq.push(diff);
                } else {
                    if (pq.empty() || pq.top() >= diff) {
                        bricks -= diff;
                    } else {
                        int nextLadder = pq.top();
                        pq.pop();

                        bricks -= nextLadder;
                        pq.push(diff);
                    }

                    if (bricks < 0) return idx;
                }
            }
        }

        return heights.size() - 1;
    }
};
