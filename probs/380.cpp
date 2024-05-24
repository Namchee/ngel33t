#include <unordered_map>
#include <vector>
using namespace std;

class RandomizedSet {
public:
    RandomizedSet() {
        
    }
    
    bool insert(int val) {
        if (mp.find(val) == mp.end()) {
            mp[val] = temp.size();
            temp.push_back(val);

            return true;
        }

        return false;
    }
    
    bool remove(int val) {
        if (mp.find(val) == mp.end()) {
            return false;
        }

        temp[mp[val]] = temp[temp.size() - 1];
        mp[temp[temp.size() - 1]] = mp[val];

        temp.pop_back();
        mp.erase(val);

        return true;
    }
    
    int getRandom() {
        return temp[rand() % temp.size()];
    }

private:
    unordered_map<int, int> mp;
    vector<int> temp;
};

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * RandomizedSet* obj = new RandomizedSet();
 * bool param_1 = obj->insert(val);
 * bool param_2 = obj->remove(val);
 * int param_3 = obj->getRandom();
 */
