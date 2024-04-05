#include <string>
#include <stack>
using namespace std;

class Solution {
public:
    string makeGood(string s) {
        stack<char> stk;

        for (char c: s) {
            if (!stk.empty()) {
                char a = stk.top();

                if (a != c && tolower(a) == tolower(c)) {
                    stk.pop();
                } else {
                    stk.push(c);
                }
            } else {
                stk.push(c);
            }
        }

        string result;
        while (!stk.empty()) {
            result = stk.top() + result;
            stk.pop();
        }

        return result;
    }
};
