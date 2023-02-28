#include <unordered_map>
#include <unordered_set>
#include <string>
using namespace std;

bool isIsomorphic(string s, string t)
{
    unordered_set<char> chs, cht;
    unordered_map<char, char> char_map;

    for (int i = 0; i < s.length(); i++)
    {
        chs.insert(s[i]);
        cht.insert(t[i]);

        if (char_map.find(s[i]) == char_map.end())
        {
            char_map[s[i]] = t[i];
            continue;
        }

        char ref = char_map[s[i]];
        if (ref != t[i])
        {
            return false;
        }
    }

    return chs.size() == cht.size();
}
