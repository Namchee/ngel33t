#include <vector>
#include <cmath>
using namespace std;

class Solution {
public:
    int kthFactor(int n, int k) {
        vector<int> factors(n, 0);

        int l = 0;
        int r = factors.size() - 1;

        for (int i = 1; i <= sqrt(n); i++) {
            if (n % i == 0) {
                factors[l++] = i;

                if (n / i != i) {
                    factors[r--] = n / i;
                }
            }
        }

        int end = factors.size();
        for (int i = r + 1; i < factors.size() && l < i; i++, l++) {
            factors[l] = factors[i];
            factors[i] = 0;
            end = l;
        }

        return k - 1 > end ? -1 : factors[k - 1];
    }
};