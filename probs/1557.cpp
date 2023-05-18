#include <vector>
using namespace std;

class Solution {
public:
    vector<int> findSmallestSetOfVertices(int n, vector<vector<int>>& edges) {
        int ins[n];
        for (int idx = 0; idx < n; idx++) {
            ins[idx] = 0;
        }

        for (int idx = 0; idx < edges.size(); idx++) {
            int to = edges[idx][1];

            ins[to]++;
        }        

        vector<int> result;

        for (int idx = 0; idx < n; idx++) {
            if (ins[idx] == 0) {
                result.push_back(idx);
            }
        }

        return result;
    }
};
