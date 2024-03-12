#include <unordered_map>;
using namespace std;

class Solution {
public:
    int minimumOneBitOperations(int n) {
        if (memo.find(n) != memo.end()) {
            return memo[n];
        }

        if (n <= 1) {
            memo[n] = n;
            return n;
        }

        int left = getLeftmostBitPosition(n);
        // this is the mask
        int prefix = (1 << left) | (1 << (left - 1));

        int masked = minimumOneBitOperations(n ^ prefix);
        // memo(2 ^ k) = (2 ^ k + 1) - 1;
        int pow2 = (1 << left) - 1;

        return memo[n] = masked + pow2 + 1;
    }

private:
    unordered_map<int, int> memo;

    int getLeftmostBitPosition(int n) {
        int curr = 0;

        while (n > 1) {
            n >>= 1;
            curr++;
        }

        return curr;
    }
};
