#include <string>
#include <vector>
using namespace std;

int countCharacters(vector<string> &words, string chars)
{
    vector<int> dict(26, 0);
    for (int idx = 0; idx < chars.length(); idx++)
    {
        dict[chars[idx] - 'a']++;
    }

    int len = 0;
    for (int idx = 0; idx < words.size(); idx++)
    {
        vector<int> letters(26, 0);
        for (int idc = 0; idc < words[idx].length(); idc++)
        {
            letters[words[idx][idc] - 'a']++;
        }

        if (can_be_formed(dict, letters))
        {
            len += words[idx].length();
        }
    }

    return len;
}

bool can_be_formed(vector<int> &dict, vector<int> &target)
{
    for (int idx = 0; idx < 26; idx++)
    {
        if (dict[idx] < target[idx])
        {
            return false;
        }
    }

    return true;
}