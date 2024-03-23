#include <vector>
using namespace std;

class Solution
{
public:
    vector<int> decrypt(vector<int> &code, int k)
    {
        int n = code.size();
        vector<int> res(n, 0);
        if (k == 0)
        {
            return res;
        }

        int sum = 0;
        if (k > 0)
        {
            int j = 0, window = 0;
            while (j < k)
            {
                window += code[j];
                j++;
            }
            for (int i = 0; i < n; i++)
            {
                window = window - code[i] + code[(i + k) % n];
                res[i] = window;
            }
        }
        else
        {
            int window = 0;

            for (int j = n + k; j < n; j++)
            {
                window = window + code[j];
            }
            for (int l = n - 1; l >= 0; l--)
            {
                int indx = 0;
                if ((l + k) < 0)
                {
                    indx = (l + k + n) % n;
                }
                else
                {
                    indx = (l + k) % n;
                }
                window = window - code[l] + code[indx];
                res[l] = window;
            }
        }
        return res;
    }
};
