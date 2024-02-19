#include <string>;
#include <vector>;
using namespace std;

vector<int> plusOne(vector<int> &digits)
{
    int borrow = 0;

    int sum = borrow + digits[digits.size() - 1] + 1;
    borrow = sum / 10 ? 1 : 0;

    digits[digits.size() - 1] = sum % 10;

    for (int i = digits.size() - 2; i >= 0; i--)
    {
        int sum = borrow + digits[i];
        borrow = sum / 10 ? 1 : 0;

        digits[i] = sum % 10;
    }

    if (borrow)
    {
        digits.insert(digits.begin(), 1);
    }

    return digits;
}
