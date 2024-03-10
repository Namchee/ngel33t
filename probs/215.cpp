#include <vector>;
#include <queue>;
using namespace std;

class Solution {
public:
    int findKthLargest(vector<int>& nums, int k) {
        priority_queue<int> pq;
        for (auto num: nums) {
            pq.push(num);
        }

        int last;
        while (k--) {
            last = pq.top();
            pq.pop();
        }

        return last;
    }
};
