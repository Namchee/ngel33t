#include <vector>;
#include <string>;
#include <algorithm>;
using namespace std;

bool compareFn(int a, int b) {
    string str_a = to_string(a);
    string str_b = to_string(b);

    return (str_a + str_b) > (str_b + str_a);
}
 
class Solution {
public:
    string largestNumber(vector<int>& nums) {
        sort(nums.begin(), nums.end(), compareFn);
        
        string concat = "";
        for (int idx = 0; idx < nums.size(); idx++) {
            concat += to_string(nums[idx]);
        }

        bool only_zero = true;
        for (int idx = 0; idx < concat.size() && only_zero; idx++) {
            if (concat[idx] != '0') {
                return concat;
            }
        }

        return "0";
    }
};
