#include <map>;
#include <string>;
#include <algorithm>;
using namespace std;

map<char, int> mp;

bool compare(char a, char b) {
    if (mp.find(a) == mp.end()) {
        return false;
    }

    if (mp.find(b) == mp.end()) {
        return true;
    }

    return mp[a] < mp[b];
}

class Solution {
public:
    string customSortString(string order, string s) {
        for (int i = 0; i < order.size(); i++) {
            mp[order[i]] = i;
        }


        sort(s.begin(), s.end(), compare);

        return s;
    }
};
