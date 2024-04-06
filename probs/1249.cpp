
#include <string>
#include <stack>
using namespace std;

class Solution {
public:
    string minRemoveToMakeValid(string s) {
        string result;

        stack<int> stk;

        for (int i = 0; i < s.length(); i++) {
            char c = s[i];
            if (c == '(') {
                stk.push(i);
                s[i] = '*';
            }  
            
            if (c == ')') {
                if (!stk.empty()) {
                    int replace = stk.top();
                    s[replace] = '(';
                    stk.pop();
                } else {
                    s[i] = '*';
                }
            }
        }

        for (char c: s) {
            if (c != '*') {
                result += c;
            }
        }

        return result;
    }
};
