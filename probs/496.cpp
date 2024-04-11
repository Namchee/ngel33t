#include <vector>
#include <unordered_map>
#include <stack>
using namespace std;

class Solution {
public:
    vector<int> nextGreaterElement(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int, int> mp;
        stack<int> stk;

        for (int i = nums2.size() - 1; i >= 0; i--) {
            int last = -1;
            while (!stk.empty()) {
                if (stk.top() > nums2[i]) {
                    last = stk.top();
                    break;
                }

                stk.pop();
            }

            stk.push(nums2[i]);
            mp[nums2[i]] = last;
        }

        vector<int> result;

        for (int num: nums1) {
            result.push_back(mp[num]);
        }

        return result;
    }
};
