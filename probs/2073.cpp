#include <vector>
using namespace std;

class Solution {
public:
    int timeRequiredToBuy(vector<int>& tickets, int k) {
        int n = tickets.size();
        int time = 0;
        int much = tickets[k];
        for (int i = 0; i < n; i++) {
            int t = i > k ? much - 1 : much;
            time += min(t, tickets[i]);
        }

        return time;
    }
};
