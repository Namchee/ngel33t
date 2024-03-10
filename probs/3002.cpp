#include <vector>;
#include <unordered_set>;
using namespace std;

class Solution {
public:
    int maximumSetSize(vector<int>& nums1, vector<int>& nums2) {
        int maxEl = nums1.size() / 2;

        unordered_set<int> s1(nums1.begin(), nums1.end());
        unordered_set<int> s2(nums2.begin(), nums2.end());
        unordered_set<int> temp;
        for (int num: nums1) {
            temp.insert(num);
        }
        for (int num: nums2) {
            temp.insert(num);
        }

        int max1 = s1.size() < maxEl ? s1.size() : maxEl;
        int max2 = s2.size() < maxEl ? s2.size() : maxEl;

        return min((int)temp.size(), max1 + max2);
    }
};
