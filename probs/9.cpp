#include <vector>
#include <map>
#include <iostream>
using namespace std;

bool isPalindrome(int x)
{
    if (x < 0)
    {
        return false;
    }

    unsigned long long cpy = x;
    unsigned long long newNumber = 0;

    while (cpy > 0)
    {
        newNumber = newNumber * 10 + cpy % 10;
        cpy /= 10;
    }

    return x == newNumber;
}

int main()
{
    int num = 12321;

    cout << isPalindrome(num) << "\n";

    return 0;
}
