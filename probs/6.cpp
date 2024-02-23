#include <string>;
using namespace std;

class Solution {
public:
    string convert(string s, int numRows) {
        if (numRows == 1) {
            return s;
        }
        
        char temp[numRows][1001];
        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < 1001; j++) {
                temp[i][j] = ' ';
            }
        }

        int acc_x = 1;
        int acc_y = 0;

        int i = 0;
        int j = 0;
        int idx = 0;

        while (idx < s.size()) {
            temp[i][j] = s[idx++];

            if (i == numRows - 1) {
                acc_x = -1;
                acc_y = 1;
            } 
            
            if (i == 0) {
                acc_x = 1;
                acc_y = 0;
            }

            i += acc_x;
            j += acc_y;
        }

        string res;

        for (int a = 0; a < numRows; a++) {
            for (int b = 0; b <= j; b++) {
                if (temp[a][b] != ' ') {
                    res += temp[a][b];
                }
            }
        }

        return res;
    }
};
