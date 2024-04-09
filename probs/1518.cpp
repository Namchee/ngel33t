class Solution {
public:
    int numWaterBottles(int numBottles, int numExchange) {
        int sum = 0;
        int rest = 0;

        while (numBottles) {
            sum += numBottles;

            int a = numBottles % numExchange;
            numBottles = numBottles / numExchange;
            int leftovers = rest + (a);

            numBottles += leftovers / numExchange;
            rest = leftovers % numExchange;
        }

        return sum;
    }
};
