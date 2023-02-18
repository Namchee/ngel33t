#include <iostream>
using namespace std;

// Space efficient fibonacci implementation
// Time Complexity: O(n)
// Space Complexity: O(1)
int main()
{
    int a = 0;
    int b = 1;

    int i = 2;  // current iteration
    int result; // temp

    int n;

    cin >> n;

    while (i < n)
    {
        result = a + b;
        a = b;
        b = result;

        i++;
    }

    cout << result;

    return 0;
}