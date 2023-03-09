#include <unordered_map>
#include <string>
#include <vector>
using namespace std;

string longestCommonPrefix(vector<string> &strs)
{
    string curr = "";
    int len = 1;

    while (true)
    {
        if (len > strs[0].length())
        {
            return curr;
        }

        string ref = strs[0].substr(0, len);

        for (int i = 1; i < strs.size(); i++)
        {
            string com = strs[i].substr(0, len);

            if (com != ref)
            {
                return curr;
            }
        }

        curr = ref;
        len++;
    }

    return curr;
}