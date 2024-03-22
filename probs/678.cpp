#include <string>;
#include <stack>;
using namespace std;

class Solution {
public:
    bool checkValidString(string s) {
        stack<int> stk, free;

        for (int i = 0; i < s.length(); i++) {
            switch (s[i]) {
                case '(':
                    stk.push(i);
                    break;
                case ')':
                    if (!stk.empty()) {
                        stk.pop();
                        break;
                    }

                    if (!free.empty()) {
                        free.pop();
                        break;
                    }
                    
                    return false;
                default:
                    free.push(i);
                    break;
            }
        }

        while (!stk.empty() && !free.empty() && free.top() > stk.top()) {
            stk.pop();
            free.pop();
        }

        return stk.empty();
    }
};
