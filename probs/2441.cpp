#include <vector>
#include <unordered_set>
using namespace std;

class Solution {
public:
    int findMaxK(vector<int>& nums) {
        vector<int> positives;
        unordered_set<int> numbers;

        for (int num: nums) {
            if (num > 0) {
                positives.push_back(num);
            }

            numbers.insert(num);
        }

        int res = -1;
        for (int num: positives) {
            if (numbers.find(num * -1) != numbers.end() && res < num) {
                res = num;
            }
        }

        return res;
    }
};