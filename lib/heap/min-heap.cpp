#include <iostream>
#include <queue>
#include <vector>
using namespace std;

int main()
{
    // 1. what you want to store
    // 2. where should we store it
    // 3. comparator function, in this case, prioritize smaller on top.
    priority_queue<int, vector<int>, greater<int>> min_heap;
    return 0;
}