#include <string>
using namespace std;

class Solution {
public:
    int maxConsecutiveAnswers(string answerKey, int k) {
        return max(getMaximumWindowSize(answerKey, 'T', k), getMaximumWindowSize(answerKey, 'F', k));
    }

private:
    int getMaximumWindowSize(string str, char c, int k) {
        int ans = 0;
        int start = 0;
        int end = 0;

        int diff = 0;

        while (end < str.size()) {
            diff += str[end] != c;

            while (diff > k) {
                diff -= str[start++] != c;
            }

            ans = max(ans, end - start + 1);
            end++;
        }

        return ans;
    }
};
