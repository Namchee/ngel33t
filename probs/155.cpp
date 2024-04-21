#include <stack>
#include <climits>
using namespace std;

class MinStack {
public:
    MinStack() {
        
    }
    
    void push(int val) {
        stk.push(val);
        if (val <= getMin()) {
            temp.push(val);
        }
    }
    
    void pop() {
        int value = stk.top();
        stk.pop();
        if (value == temp.top()) {
            temp.pop();
        }
    }
    
    int top() {
        return stk.top();
    }
    
    int getMin() {
        return temp.empty() ? INT_MAX : temp.top();
    }

private:
    stack<int> stk, temp;
};

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack* obj = new MinStack();
 * obj->push(val);
 * obj->pop();
 * int param_3 = obj->top();
 * int param_4 = obj->getMin();
 */
