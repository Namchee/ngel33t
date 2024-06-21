#include <vector>
using namespace std;

class Solution {
public:
    int maxSatisfied(vector<int>& customers, vector<int>& grumpy, int minutes) {
        int n = customers.size();
        int best = 0;
        for (int i = 0; i < n; i++) {
            best += grumpy[i] == 0 ? customers[i] : 0;
        }

        int bonus = 0;
        for (int i = 0; i < minutes; i++) {
            bonus += grumpy[i] == 1 ? customers[i] : 0;
        }

        int curr = bonus;

        for (int i = minutes; i < n; i++) {
            curr += grumpy[i] == 1 ? customers[i] : 0;
            curr -= grumpy[i - minutes] == 1 ? customers[i - minutes] : 0;
            bonus = max(bonus, curr);
        }

        return best + bonus;
    }
};
