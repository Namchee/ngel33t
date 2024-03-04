#include <vector>;
using namespace std;

class Solution {
public:
    int latestTimeCatchTheBus(vector<int>& buses, vector<int>& passengers, int capacity) {
        sort(buses.begin(), buses.end());
        sort(passengers.begin(), passengers.end());

        for (int i = 0; i < buses.size() - 1; i++) {
            int curr = capacity;

            while (curr > 0 && passengers[0] <= buses[i]) {
                passengers.pop_front();
                curr--;
            }
        }

        vector<int> pass;
        int curr = capacity;

        while (curr > 0 && passengers[0] <= buses[i]) {
            pass.push_back(passengers[0]);
            passengers.pop_front();
            curr--;
        }

        pass.push_back(buses[buses.size() - 1]);
        if (pass.size() > capacity) {
            
        }
    }
};