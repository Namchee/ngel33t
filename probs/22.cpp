#include <vector>
#include <string>
using namespace std;

vector<string> generateParenthesis(int n)
{
    vector<string> result;

    backtrack(result, "", 0, n * 2);

    return result;
}

void backtrack(vector<string> &result, string curr, int balance, int rem)
{
    if (balance < 0)
    {
        return;
    }

    if (rem == 0)
    {
        if (balance == 0)
        {
            result.push_back(curr);
        }
        return;
    }

    backtrack(result, curr + '(', balance + 1, rem - 1);
    backtrack(result, curr + ')', balance - 1, rem - 1);
}