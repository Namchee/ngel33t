#include <vector>;
using namespace std;

class Solution {
public:
    vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
        int freq1[1001] = { 0 };
        int freq2[1001] = { 0 };

        vector<int> result;

        for (int num: nums1) {
            freq1[num]++;
        } 
        for (int num: nums2) {
            freq2[num]++;
        }

        for (int i = 0; i < 1001; i++) {
            if (freq1[i] && freq2[i]) {
                result.push_back(i);
            }
        }

        return result;
    }
};
