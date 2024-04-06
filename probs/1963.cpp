#include <string>
using namespace std;

class Solution {
public:
    int minSwaps(string s) {
        int sz = 0;
        for (char c: s) {
            if (c == '[') {
                sz++;
            } else {
                if (sz) {
                    sz--;
                }
            }
        }

        return (sz + 1) / 2;
    }
};
