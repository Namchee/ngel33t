#include <vector>;
#include <cmath>;
using namespace std;

class Solution {
public:
    int findPoisonedDuration(vector<int>& time, int duration) {
        int previous = -1;
        int answer = 0;

        for (int i: time) {
            answer += duration;

            if (previous >= i) {
                answer = answer - abs(previous - i) - 1; 
            }

            previous = i + duration - 1;
        }

        return answer;
    }
};
