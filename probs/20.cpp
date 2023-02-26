#include <stack>
#include <map>
#include <string>
using namespace std;

bool isValid(string s)
{
    stack<char> st;

    map<char, char> pair = {
        {')', '('},
        {']', '['},
        {'}', '{'}};

    for (int i = 0; i < s.length(); i++)
    {
        if (s[i] == '(' || s[i] == '[' || s[i] == '{')
        {
            st.push(s[i]);
        }
        else
        {
            char pp = pair[s[i]];
            if (st.empty() || st.top() != pp)
            {
                return false;
            }

            st.pop();
        }
    }

    return st.size() == 0;
}