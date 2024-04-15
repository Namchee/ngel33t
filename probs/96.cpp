class Solution {
public:
    int numTrees(int n) {
        // use Catalan Numbers -> https://www.enjoyalgorithms.com/blog/total-number-of-binary-search-trees-with-n-keys
        unsigned long long count = 1;
        for (int i = 0; i < n; i++) {
            count *= (2 * n - i);
            count /= i + 1;
        }

        return count / (n + 1);
    }
};
