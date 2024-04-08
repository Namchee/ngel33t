#include <vector>
#include <queue>
using namespace std;

class Solution {
public:
    int countStudents(vector<int>& students, vector<int>& sandwiches) {
        queue<int> q;
        for (int s: students) {
            q.push(s);
        }

        int s = 0;
        while (!q.empty()) {
            int count = 0;
            int prevSize = q.size();

            while (count < prevSize) {
                int front = q.front();
                q.pop();

                if (front == sandwiches[s]) {
                    s++;
                    break;
                } else {
                    q.push(front);
                }

                count++;
            }

            if (count == prevSize) {
                return prevSize;
            }
        }

        return 0;
    }
};
