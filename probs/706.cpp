#include <vector>
using namespace std;

class MyHashMap {
public:
    MyHashMap() {
        container.resize(1e6 + 1, -1);
    }
    
    void put(int key, int value) {
        container[key] = value;
    }
    
    int get(int key) {
        return container[key];
    }
    
    void remove(int key) {
        container[key] = -1;
    }

private:
    vector<int> container;
};

/**
 * Your MyHashMap object will be instantiated and called as such:
 * MyHashMap* obj = new MyHashMap();
 * obj->put(key,value);
 * int param_2 = obj->get(key);
 * obj->remove(key);
 */
