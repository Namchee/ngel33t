#include <vector>;
using namespace std;

class Solution {
public:
    int getMaximumGenerated(int n) {
        if (n == 0) {
            return 0;
        }
        
        n++;
        vector<int> arr(n, 0);
        arr[1] = 1;

        int best = 1;
        for (int i = 2; i < n; i += 2) {
            int ref = i / 2;

            arr[i] = arr[ref];
            best = max(best, arr[i]);

            if (i + 1 < n) {
                arr[i + 1] = arr[ref] + arr[ref + 1]; 
                best = max(best, arr[i + 1]);
            }
        }

        return best;
    }
};
