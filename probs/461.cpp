#include <vector>
#include <map>
#include <iostream>
using namespace std;

int hammingDistance(int x, int y)
{
    return hamming_weight(x ^ y);
}

int hamming_weight(int x)
{
    int count = 0;
    while (x)
    {
        count += x & 1;
        x >>= 1;
    }

    return count;
}
