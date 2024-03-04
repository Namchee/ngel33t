#include <vector>;
using namespace std;

class Solution {
public:
    int latestTimeCatchTheBus(vector<int>& buses, vector<int>& passengers, int capacity) {
        sort(buses.begin(), buses.end());
        sort(passengers.begin(), passengers.end());

        int begin = 0;

        for (int i = 0; i < buses.size() - 1; i++) {
            int curr = capacity;

            while (curr > 0 && begin < passengers.size() && passengers[begin] <= buses[i]) {
                begin++;
                curr--;
            }
        }

        vector<int> pass;
        int curr = capacity;

        while (curr > 0 && begin < passengers.size() && passengers[begin] <= buses[buses.size() - 1]) {
            pass.push_back(passengers[begin]);
            begin++;
            curr--;
        }

        int limit = buses[buses.size() - 1];
        if (pass.size() == capacity) {
            limit = pass[pass.size() - 1];
        }

        while (binary_search(passengers.begin(), passengers.end(), limit)) {
            limit--;
        }

        return limit;
    }
};