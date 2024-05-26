#include <vector>
using namespace std;

class Solution {
public:
    int checkRecord(int n) {
        table.resize(n + 1, vector<vector<int> >(2, vector<int>(3, -1)));

        return backtrack(n, 0, 0);
    }

private:
    vector<vector<vector<int> > > table;

    int backtrack(int day, int absent, int late) {
        // impossible situations
        if (absent > 1 || late > 2) {
            return 0;
        }

        // there's only one way to reach day '0' = by existing
        if (day == 0) {
            return 1;
        }

        if (table[day][absent][late] != -1) {
            return table[day][absent][late];
        }

        // pick 'P'
        int count = backtrack(day - 1, absent, 0);
        // pick 'A'
        count = (count + backtrack(day - 1, absent + 1, 0)) % 1000000007;
        // pick 'L'
        count = (count + backtrack(day - 1, absent, late + 1)) % 1000000007;

        return table[day][absent][late] = count;
    }
};
