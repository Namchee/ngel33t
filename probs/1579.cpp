#include <vector>
#include <unordered_set>
using namespace std;

class UnionFind {
public:
    UnionFind(int n) {
        this->root.resize(n + 1);
        this->rank.resize(n + 1);

        for (int i = 0; i < n + 1; i++) {
            this->root[i] = i;
        }
    }

    int find(int node) {
        if (node == this->root[node]) {
            return node;
        }

        return this->root[node] = this->find(this->root[node]);
    }

    bool unite(int x, int y) {
        int rootA = this->find(x);
        int rootB = this->find(y);

        if (rootA == rootB) {
            return false;
        }

        if (this->rank[rootA] >= this->rank[rootB]) {
            this->root[rootB] = rootA;
            if (this->rank[rootA] == this->rank[rootB]) {
                this->rank[rootA]++;
            }
        } else {
            this->root[rootA] = rootB;
        }

        return true;
    }

    bool isConnected() {
        unordered_set<int> components;
        for (int i = 1; i < this->root.size(); i++) {
            components.insert(this->find(i));
        }

        return components.size() == 1;
    }

private:
    vector<int> root, rank;
};

class Solution {
public:
    int maxNumEdgesToRemove(int n, vector<vector<int>>& edges) {
        UnionFind a(n), b(n);

        int result = 0;
        for (vector<int>& edge: edges) {
            if (edge[0] == 3) {
                result += (a.unite(edge[1], edge[2]) | b.unite(edge[1], edge[2]));
            }
        }

        for (vector<int>& edge: edges) {
            if (edge[0] == 1) {
                result += a.unite(edge[1], edge[2]);
            } else if (edge[0] == 2) {
                result += b.unite(edge[1], edge[2]);
            }
        }

        if (a.isConnected() && b.isConnected()) {
            return edges.size() - result; 
        }

        return -1;
    }
};
