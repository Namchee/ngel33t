#include <vector>
using namespace std;

vector<int> getNoZeroIntegers(int n)
{
    for (int ct = 1; ct < n; ct++)
    {
        if (
            !has_zero(ct) &&
            !has_zero(n - ct))
        {
            return {ct, n - ct};
        }
    }

    return {};
}

bool has_zero(int n)
{
    while (n)
    {
        int mod = n % 10;
        if (!mod)
        {
            return true;
        }

        n /= 10;
    }

    return false;
}