#include <vector>
using namespace std;

// Sieve of erathostenes
// Good for deterining if N is prime in streaming
// Bad if only few numbers, better use O(sqrt(N)) algo
//
// Time complexity: O(N log (log N))
int sieve(int n)
{
    vector<bool> is_prime(n + 1, true);

    for (int i = 2; i <= n; i++)
    {
        if (is_prime[i])
        {
            for (int j = i * i; j <= n; j += i)
            {
                is_prime[j] = false;
            }
        }
    }
}