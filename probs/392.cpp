#include <string>
using namespace std;

bool isSubsequence(string s, string t)
{
    int n = 0;
    int m = 0;

    while (n < s.length() && m < t.length())
    {
        if (s[n] == t[m])
        {
            n++;
            m++;
        }
        else
        {
            m++;
        }
    }

    return n == s.length();
}