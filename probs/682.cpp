#include <stack>
#include <vector>
#include <string>
using namespace std;

class Solution
{
public:
    int calPoints(vector<string> &operations)
    {
        stack<int> stk;

        for (string op : operations)
        {
            if (op == "C")
            {
                stk.pop();
            }
            else if (op == "D")
            {
                stk.push(2 * stk.top());
            }
            else if (op == "+")
            {
                int a = stk.top();
                stk.pop();
                int b = stk.top();
                stk.pop();
                int c = a + b;
                stk.push(b);
                stk.push(a);
                stk.push(c);
            }
            else
            {
                stk.push(stoi(op));
            }
        }

        int count = 0;
        while (!stk.empty())
        {
            count += stk.top();
            stk.pop();
        }

        return count;
    }
};
