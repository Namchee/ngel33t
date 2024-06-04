#include <stack>
#include <string>
#include <vector>
using namespace std;

class Solution {
public:
    int evalRPN(vector<string>& tokens) {
        stack<int> stk;

        for (string str: tokens) {
            if (str != "+" && str != "-" && str != "*" && str != "/") {
                stk.push(stoi(str));
            } else {
                int b = stk.top();
                stk.pop();
                int a = stk.top();
                stk.pop();

                if (str == "+") {
                    stk.push(a + b);
                } else if (str == "-") {
                    stk.push(a - b);
                } else if (str == "*") {
                    stk.push(a * b); 
                } else {
                    stk.push(a / b);
                }
            }
        }

        return stk.top();
    }
};
