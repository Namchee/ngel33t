#include <string>
using namespace std;

string addBinary(string a, string b)
{
    while (a.length() < b.length())
    {
        a = '0' + a;
    }

    while (b.length() < a.length())
    {
        b = '0' + b;
    }

    string res;

    int cursor = a.length() - 1;
    int borrow = 0;

    while (cursor >= 0)
    {
        int chA = a[cursor] == '1' ? 1 : 0;
        int chB = b[cursor] == '1' ? 1 : 0;

        int sum = chA + chB + borrow;

        switch (sum)
        {
        case 3:
        {
            res = '1' + res;
            borrow = 1;
            break;
        }
        case 2:
        {
            res = '0' + res;
            borrow = 1;
            break;
        }
        case 1:
        {
            res = '1' + res;
            borrow = 0;
            break;
        }
        default:
        {
            res = '0' + res;
            borrow = 0;
            break;
        }
        }
        cursor--;
    }

    if (borrow > 0)
    {
        res = '1' + res;
    }

    return res;
}