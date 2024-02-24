#include <unordered_map>;
#include <set>;
using namespace std;

class NumberContainers {
public:
    unordered_map<int, int> mapper;
    unordered_map<int, set<int> > value_idx;

    void change(int index, int number) {
        auto it = mapper.find(index);
        if (it != end(mapper)) {
            value_idx[it->second].erase(index);
        }

        mapper[index] = number;
        value_idx[number].insert(index);
    }
    
    int find(int number) {
        if (value_idx.find(number) == value_idx.end() || value_idx[number].empty()) {
            return -1;
        }

        return *value_idx[number].begin();
    }
};

/**
 * Your NumberContainers object will be instantiated and called as such:
 * NumberContainers* obj = new NumberContainers();
 * obj->change(index,number);
 * int param_2 = obj->find(number);
 */
