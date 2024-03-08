#include <vector>;
using namespace std;

class Solution {
public:
    int maxFrequencyElements(vector<int>& nums) {
        int freq[101] = { 0 };
        int res = 0;
        for (auto num: nums) {
            freq[num]++;

            res = max(res, freq[num]);
        }

        int el = 0;
        for (auto fre: freq) {
            if (fre == res) {
                el += fre;
            }
        }

        return el;
    }
};
