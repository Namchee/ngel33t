#include <vector>
using namespace std;

class Solution {
public:
    int countTriplets(vector<int>& arr) {
        vector<int> prefix(arr.size() + 1, 0);

        for (int i = 0; i < arr.size(); i++) {
            prefix[i + 1] = arr[i] ^ prefix[i];
        }

        int count = 0;

        for (int i = 0; i < arr.size(); i++) {
            for (int j = i + 1; j < arr.size(); j++) {
                if (prefix[i] == prefix[j + 1]) {
                    count += j - i;
                }
            }
        }

        return count;
    }
};
