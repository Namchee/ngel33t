#include <cmath>
#include <vector>
using namespace std;

vector<int> addToArrayForm(vector<int> &num, int k)
{
    int borrow = 0;
    int pointer = num.size() - 1;

    while (k && pointer >= 0)
    {
        int sum = k % 10 + num[pointer] + borrow;

        borrow = sum >= 10 ? 1 : 0;
        num[pointer--] = sum % 10;
        k /= 10;
    }

    while (pointer >= 0)
    {
        int sum = num[pointer] + borrow;

        borrow = sum >= 10 ? 1 : 0;
        num[pointer--] = sum % 10;
    }

    while (k)
    {
        int sum = k % 10 + borrow;
        borrow = sum >= 10 ? 1 : 0;

        num.insert(num.begin(), sum % 10);
        k /= 10;
    }

    if (borrow)
    {
        num.insert(num.begin(), 1);
    }

    return num;
}