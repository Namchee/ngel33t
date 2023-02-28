#include <unordered_set>
using namespace std;

bool isHappy(int n)
{
    unordered_set<int> calc;

    while (calc.find(n) == calc.end())
    {
        calc.insert(n);

        int temp = 0;
        while (n)
        {
            temp += pow(n % 10, 2);
            n /= 10;
        }

        n = temp;
    }

    return n == 1;
}