#include <vector>;
using namespace std;

class Solution {
public:
    bool isRestTen(vector<int>& data) {
        for (int idx = 0; idx < data.size(); idx++) {
            if (data[idx] < 128 || data[idx] >= 192) {
                return false;
            }
        }

        return true;
    }

    int getType(int num) {
        if (num < 128) return 0;
        else if (num >= 192 && num < 224) return 1;
        else if (num >= 224 && num < 240) return 2;
        else if (num >= 240 && num < 248) return 3;
        return -1;
    }

    bool validUtf8(vector<int>& data) {
        int idx = 0;

        for (; idx < data.size(); idx++) {
            int type = getType(data[idx]);
            if (type == 0) {
                continue;
            }

            if (type == -1 || idx + type >= data.size()) { 
                return false;
            }

            vector<int> sub(data.begin() + 1 + idx, data.begin() + 1 + idx + type);
            if (!isRestTen(sub)) {
                return false;
            }

            idx += type;
        }

        return true;
    }
};
