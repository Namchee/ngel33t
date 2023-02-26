#include <map>
#include <iostream>
#include <string>
using namespace std;

string intToRoman(int num)
{
    map<int, string> mp = {
        {1, "I"},
        {5, "V"},
        {10, "X"},
        {50, "L"},
        {100, "C"},
        {500, "D"},
        {1000, "M"},
        {4, "IV"},
        {9, "IX"},
        {40, "XL"},
        {90, "XC"},
        {400, "CD"},
        {900, "CM"},
    };

    string s;
    int temp = 0;
    string curr;

    while (num > 0)
    {
        for (auto it = mp.begin(); it != mp.end(); it++)
        {
            int n = it->first;

            if (n <= num)
            {
                temp = n;
                curr = it->second;
            }
            else
            {
                break;
            }
        }

        num -= temp;
        s += curr;
    }

    return s;
}

int main()
{
    string s = intToRoman(3);

    cout << s << endl;
}
