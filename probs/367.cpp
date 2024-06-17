#include <cmath>
using namespace std;

class Solution {
public:
    bool isPerfectSquare(int num) {
        double root = sqrt(num);

        return ceil(root) == floor(root);
    }
};
