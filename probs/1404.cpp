#include <vector>
#include <string>
using namespace std;

class Solution
{
public:
    int numSteps(string s)
    {
        vector<char> str(s.begin(), s.end());
        vector<int> arr;
        for (char c : str)
        {
            arr.push_back(c == '0' ? 0 : 1);
        }

        int count = 0;

        while (arr.size() > 1)
        {
            if (arr[arr.size() - 1] == 1)
            {
                add(arr);
            }
            else
            {
                divide(arr);
            }

            arr = shrink(arr);
            count++;
        }

        return count;
    }

private:
    void add(vector<int> &arr)
    {
        int idx = arr.size() - 1;

        int carry = arr[idx] == 0 ? 0 : 1;
        arr[idx] = arr[idx] == 0 ? 1 : 0;
        idx--;

        while (idx >= 0)
        {
            arr[idx] += carry;
            if (arr[idx] > 1)
            {
                arr[idx] = 0;
                carry = 1;
            }
            else
            {
                carry = 0;
            }

            idx--;
        }

        if (carry)
        {
            arr.emplace(arr.begin(), 1);
        }
    }

    void divide(vector<int> &arr)
    {
        int n = arr.size();

        for (int i = n - 2; i >= 0; i--)
        {
            arr[i + 1] = arr[i];
        }

        arr[0] = 0;
    }

    vector<int> shrink(vector<int> &arr)
    {
        vector<int> result;
        int idx = 0;

        while (idx < arr.size())
        {
            if (arr[idx] == 1)
            {
                break;
            }
            idx++;
        }

        for (; idx < arr.size(); idx++)
        {
            result.push_back(arr[idx]);
        }

        return result;
    }
};
