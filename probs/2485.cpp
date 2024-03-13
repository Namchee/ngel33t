#include <vector>;
using namespace std;

class Solution {
public:
    int pivotInteger(int n) {
        if (n == 1) {
            return 1;
        }
        
        int sums[n];

        for (int i = 0; i < n; i++) {
            sums[i] = i + 1;
            
            if (i) {
                sums[i] += sums[i - 1];
            }
        }

        for (int i = 0; i < n - 1; i++) {
            int right = sums[n - 1] - sums[i + 1];
            int left = sums[i];

            if (left == right) {
                return i + 2;
            }
        } 

        return -1;
    }
};