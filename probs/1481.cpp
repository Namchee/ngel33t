#include <unordered_map>;
#include <queue>;
using namespace std;

class Solution {
public:
    int findLeastNumOfUniqueInts(vector<int>& arr, int k) {
        unordered_map<int, int> freq;
        for (auto el: arr) {
            freq[el]++;
        }

        priority_queue<int, vector<int>, greater<int> > q;
        for (auto idx = freq.begin(); idx != freq.end(); idx++) {
            q.push(idx->second);
        }

        while (k) {
            int el = q.top();
            if (k >= el) {
                k -= el;
                q.pop();
            } else {
                break;
            }
        }

        return q.size();
    }
};
