#include <string>
#include <stack>
using namespace std;

class Solution {
public:
    int maxDepth(string s) {
        stack<char> stk;

        int result = 0;
        for (char c: s) {
            if (c == '(') {
                stk.push('(');
            } else if (c == ')') {
                stk.pop();
            }

            if (stk.size() > result) {
                result = stk.size();
            }
        }        

        return result;
    }
};
