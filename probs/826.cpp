#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxProfitAssignment(vector<int>& difficulty, vector<int>& profit, vector<int>& worker) {
        vector<pair<int, int> > jobs;
        for (int i = 0; i < difficulty.size(); i++) {
            jobs.push_back({ difficulty[i], profit[i] });
        }

        sort(jobs.begin(), jobs.end());
        sort(worker.begin(), worker.end());

        int job = 1;

        pair<int, int> best = jobs[0];
        int result = 0;

        for (int i = 0; i < worker.size(); i++) {
            while (job < jobs.size() && jobs[job].first <= worker[i]) {
                if (jobs[job].second > best.second) {
                    best = jobs[job];
                }
                
                job++;
            }

            if (best.first <= worker[i]) {
                result += best.second;
            }
        }

        return result;
    }
};
