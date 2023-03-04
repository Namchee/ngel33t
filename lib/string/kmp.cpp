#include <string>
#include <vector>
using namespace std;

// Knuth Morris Pratt Algorithm
// Find pattern in string
// Time complexity: O(n)
// Space complexity: O(m), m is pattern length
vector<int> search_pattern(string str, string pattern)
{
    vector<int> result;

    int m = pattern.length();
    int n = str.length();

    vector<int> lps(m);

    int i = 0; // str index
    int j = 0; // pattern index

    compute_lps(pattern, lps);

    while ((n - i) >= (m - j))
    {
        if (pattern[j] == str[i])
        {
            i++;
            j++;
        }

        if (j == m)
        {
            result.push_back(i - j); // pattern found
            j = lps[j - 1];
        }
        else if (i < n && pattern[j] != str[i])
        {
            if (j != 0)
            {
                j = lps[j - 1];
            }
            else
            {
                i++;
            }
        }
    }

    return result;
}

void compute_lps(string pattern, vector<int> &lps)
{
    int len = 0;
    int i = 1;
    lps[0] = 0;

    while (i < pattern.length())
    {
        if (pattern[i] == pattern[len])
        {
            lps[i++] = ++len;
        }
        else
        {
            if (len != 0)
            {
                len = lps[len - 1];
            }
            else
            {
                lps[i++] = len;
            }
        }
    }
}