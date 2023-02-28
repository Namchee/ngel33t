#include <vector>
#include <string>
using namespace std;

vector<string> fizzBuzz(int n)
{
    vector<string> res;

    for (int i = 1; i <= n; i++)
    {
        if (i % 15 == 0)
        {
            res.push_back("FizzBuzz");
            continue;
        }

        if (i % 5 == 0)
        {
            res.push_back("Buzz");
            continue;
        }

        if (i % 3 == 0)
        {
            res.push_back("Fizz");
            continue;
        }

        res.push_back(to_string(i));
    }

    return res;
}