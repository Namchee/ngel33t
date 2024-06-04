#include <string>
using namespace std;

class Solution
{
public:
    int appendCharacters(string s, string t)
    {
        int a = 0;
        int b = 0;

        while (a < s.length())
        {
            if (s[a] == t[b])
            {
                a++;
                b++;
            }
            else
            {
                a++;
            }
        }

        return t.size() - b;
    }
};