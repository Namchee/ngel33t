#include <vector>;
#include <algorithm>;
using namespace std;

class Solution {
public:
    int leastInterval(vector<char>& tasks, int n) {
        int freq[26] = { 0 };
        for (char c: tasks) {
            freq[c - 'A']++;
        }

        sort(freq, freq + 26);
        int batch = freq[25] - 1;
        int slots = batch * n;

        for (int i = 0; i < 25; i++) {
            slots -= min(freq[i], batch);
        }

        return slots > 0 ? tasks.size() + slots : tasks.size();
    }
};
