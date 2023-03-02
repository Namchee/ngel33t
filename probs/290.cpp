#include <string>
#include <vector>
#include <sstream>
#include <unordered_set>
#include <unordered_map>
using namespace std;

bool wordPattern(string pattern, string s)
{
    vector<string> splitted;

    stringstream ss(s);
    string sss;

    while (ss >> sss)
    {
        splitted.push_back(sss);
    }

    if (splitted.size() != pattern.length())
    {
        return false;
    }

    unordered_set<string> su;
    unordered_set<char> pu;

    for (int i = 0; i < pattern.length(); i++)
    {
        pu.insert(pattern[i]);
        su.insert(splitted[i]);
    }

    if (su.size() != pu.size())
    {
        return false;
    }

    unordered_map<char, string> mp;

    for (int i = 0; i < pattern.length(); i++)
    {
        if (mp.find(pattern[i]) == mp.end())
        {
            mp[pattern[i]] = splitted[i];
        }
        else
        {
            string prev = mp[pattern[i]];
            if (prev != splitted[i])
            {
                return false;
            }
        }
    }

    return true;
}