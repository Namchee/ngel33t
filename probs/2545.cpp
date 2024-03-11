#include <vector>;
#include <algorithm>;
using namespace std;

int idx;

bool compare(const vector<int>& a, const vector<int>& b) {
    return a[idx] > b[idx];
}

class Solution {
public:
    vector<vector<int>> sortTheStudents(vector<vector<int>>& score, int k) {
        idx = k;

        sort(score.begin(), score.end(), compare);

        return score;
    }
};
