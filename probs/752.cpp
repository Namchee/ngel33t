#include <queue>
#include <unordered_set>
#include <unordered_map>
#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    int openLock(vector<string>& deadends, string target) {
        queue<pair<string, int> > q;
        unordered_set<string> visited;

        for (string d: deadends) {
            if (d == "0000") {
                return -1;
            }
            
            visited.insert(d);
        }

        visited.insert("0000");

        unordered_map<char, char> next, prev;
        for (char c = '0'; c <= '9'; ++c) {
            next[c] = (c == '9') ? '0' : c + 1;
            prev[c] = (c == '0') ? '9' : c - 1;
        }

        q.push(pair<string, int>("0000", 0));
        while (!q.empty()) {
            pair<string, int> front = q.front();
            q.pop();

            string curr = front.first;
            int step = front.second;

            if (curr == target) {
                return step;
            }

            for (int i = 0; i < 4; i++) {
                string dest = curr;
                char temp = dest[i];

                dest[i] = prev[temp];
                if (visited.find(dest) == visited.end()) {
                    visited.insert(dest);
                    q.push({ dest, step + 1 });
                }

                dest[i] = next[temp];
                if (visited.find(dest) == visited.end()) {
                    visited.insert(dest);
                    q.push({ dest, step + 1 });
                }
            }
        }

        return -1;
    }
};
