#include <string>
using namespace std;

class Solution {
public:
    bool checkRecord(string s) {
        int absent = 0;
        int currLate = 0;

        for (char c: s) {
            if (c == 'A' && absent == 1) {
                return false;
            }

            if (c == 'L' && currLate == 2) {
                return false;
            }

            currLate = c == 'L' ? currLate + 1 : 0;
            absent += c == 'A';
        }

        return true;
    }
};
