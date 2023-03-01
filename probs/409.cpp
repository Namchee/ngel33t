#include <unordered_map>
#include <string>
using namespace std;

int longestPalindrome(string s)
{
    unordered_map<char, int> freq;

    for (int i = 0; i < s.length(); i++)
    {
        freq[s[i]]++;
    }

    int best = 0;
    bool pickOne = false;

    for (auto it = freq.begin(); it != freq.end(); it++)
    {
        int f = it->second;

        if (f & 1 && !pickOne)
        {
            pickOne = true;
            best++;
        }

        best += (f / 2) * 2;
    }

    return best;
}