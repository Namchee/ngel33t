#include <iostream>
#include <vector>
#include <queue>
using namespace std;

class MedianInStream
{
public:
    priority_queue<int, vector<int>, greater<int>> min_heap;
    priority_queue<int> max_heap;

    // O(log n)
    void insert(int value)
    {
        if (this->max_heap.empty() || this->max_heap.top() >= value)
        {
            this->max_heap.push(value);
        }
        else
        {
            this->min_heap.push(value);
        }

        this->balanceHeap();
    }

    // O(log n)
    void remove(int value)
    {
        if (value <= this->max_heap.top())
        {
            // remove from max heap
        }
        else
        {
            // remove from min_heap
        }

        this->balanceHeap();
    }

    // O(log n)
    void balanceHeap()
    {
        // on odd, store the middle value on the max_heap
        if (this->max_heap.size() > this->min_heap.size() + 1)
        {
            int val = this->max_heap.top();
            this->min_heap.push(val);
            this->max_heap.pop();
        }
        else if (this->min_heap.size() > this->max_heap.size())
        {
            int val = this->min_heap.top();
            this->max_heap.push(val);
            this->min_heap.pop();
        }
    }

    double findMedian()
    {
        if (this->max_heap.size() == this->min_heap.size())
        {
            return (this->max_heap.top() + this->min_heap.top()) / 2;
        }

        return this->max_heap.top();
    }
};

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    return 0;
}