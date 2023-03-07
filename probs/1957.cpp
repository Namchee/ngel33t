#include <string>
using namespace std;

string makeFancyString(string s)
{
    string result = "";

    char prev;
    int count = 0;

    for (int idx = 0; idx < s.length(); idx++)
    {
        if (prev != s[idx])
        {
            prev = s[idx];
            count = 1;
        }
        else
        {
            count++;
        }

        if (count < 3)
        {
            result += s[idx];
        }
    }

    return result;
}