#include <vector>;
#include <queue>;
using namespace std;

class Solution {
public:
    int findContentChildren(vector<int>& g, vector<int>& s) {
        int best = 0;
        priority_queue<int> devils;
        priority_queue<int> cookies;

        for (int i = 0; i < g.size(); i++) {
            devils.push(g[i]);
        }
        for (int i = 0; i < s.size(); i++) {
            cookies.push(s[i]);
        }

        while (devils.size() && cookies.size()) {
            int devil = devils.top();
            int cookie = cookies.top();

            if (cookie >= devil) {
                devils.pop();
                cookies.pop();
                best++;
            } else {
                devils.pop();
            }
        }

        return best;
    }
};
