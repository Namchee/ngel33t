#include <unordered_map>
#include <string>
using namespace std;

int romanToInt(string s)
{
    unordered_map<string, int> mp = {
        {"I", 1},
        {"V", 5},
        {"X", 10},
        {"L", 50},
        {"C", 100},
        {"D", 500},
        {"M", 1000},
        {"IV", 4},
        {"IX", 9},
        {"XL", 40},
        {"XC", 90},
        {"CD", 400},
        {"CM", 900},
    };

    int sum = 0;
    int cursor = s.length() - 1;

    while (cursor >= 0)
    {
        string str;
        str += s[cursor];

        if (cursor > 0)
        {
            string temp;
            temp += s[cursor - 1];
            temp += s[cursor];

            if (mp.find(temp) != mp.end())
            {
                sum += mp[temp];
                cursor -= 2;
                continue;
            }
        }

        sum += mp[str];
        cursor--;
    }

    return sum;
}