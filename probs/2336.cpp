#include <set>
using namespace std;

class SmallestInfiniteSet {
public:
    SmallestInfiniteSet() {
        for (int i = 1; i <= 1000; i++) {
            st.emplace(i);
        }
    }
    
    int popSmallest() {
        int smoll = *st.begin();
        st.erase(st.begin());

        return smoll;
    }
    
    void addBack(int num) {
        st.emplace(num);
    }

private:
    set<int> st;
};
