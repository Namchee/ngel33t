#include <vector>
#include <queue>
using namespace std;

class KthLargest {
public:
    KthLargest(int k, vector<int>& nums) {
        this->limit = k;
        for (int num: nums) {
            this->pq.push(num);
            if (this->pq.size() > k) {
                this->pq.pop();
            }
        }
    }
    
    int add(int val) {
        this->pq.push(val);
        if (this->pq.size() > this->limit) {
            this->pq.pop();
        }

        return this->pq.top();
    }

private:
    priority_queue<int, vector<int>, greater<int> > pq;
    int limit;
};
