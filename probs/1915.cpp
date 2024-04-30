#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    long long wonderfulSubstrings(string word) {
        vector<long long> count(1024, 0);
        long long result = 0;
        int prefix = 0;
        count[prefix] = 1;

        for (char c: word) {
            int idx = c - 'a';
            prefix ^= 1 << idx;
            result += count[prefix];
            for (int i = 0; i < 10; i++) {
                result += count[prefix ^ (1 << i)];
            }

            count[prefix]++;
        }

        return result;
    }
};
