#include <iostream>
#include <cmath>
using namespace std;

int fibonacci(int n)
{
    int a = round(pow((1 + sqrt(5)) / 2, n));
    int b = round(pow(1 - sqrt(5) / 2, n));

    return round((a - b) / sqrt(5));
}

// Binet's formula
// Time complexity: O(1)
// Space complexity: O(1)
// awesome AF
// Do note that this counts from 0!
int main()
{
    int n;

    cin >> n;

    cout << fibonacci(n);

    return 0;
}
