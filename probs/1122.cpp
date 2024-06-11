#include <vector>
#include <map>
using namespace std;

class Solution {
public:
    vector<int> relativeSortArray(vector<int>& arr1, vector<int>& arr2) {
        map<int, int> mp;
        for (int num: arr1) {
            mp[num]++;
        }

        vector<int> result;
        for (int num: arr2) {
            while (mp[num]) {
                result.push_back(num);
                mp[num]--;
            }
        }

        for (const auto& p: mp) {
            while (p.second) {
                result.push_back(p.first);
                mp[p.first]--;
            }
        }

        return result;
    }
};
