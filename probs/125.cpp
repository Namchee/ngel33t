#include <string>
#include <regex>
using namespace std;

bool isPalindrome(string s)
{
    regex pattern("[^A-Za-z0-9]+");

    string result = regex_replace(s, pattern, "");
    for (auto &ch : result)
        ch = tolower(ch);

    for (int idx = 0; idx < result.length() / 2; idx++)
    {
        if (result[idx] != result[result.length() - 1 - idx])
        {
            return false;
        }
    }

    return true;
}