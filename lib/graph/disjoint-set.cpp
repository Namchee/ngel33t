#include <algorithm>

int parent[10000], rank[10000];

// Disjoint Set - can be used t o check if x is connected to y
// or counting number of connected components
// O(log n) on average

void make_set(int v) {
    parent[v] = v;
    rank[v] = 0;
}

int find_set(int v) {
    if (v == parent[v]) {
        return v;
    }

    return parent[v] = find_set(parent[v]);
}

void union_sets(int a, int b) {
    a = find_set(a);
    b = find_set(b);
    if (a != b) {
        if (rank[b] < rank[a]) {
            std::swap(a, b);
        }

        parent[b] = a;
        if (rank[a] == rank[b]) {
            rank[a]++;
        }
    }
}
