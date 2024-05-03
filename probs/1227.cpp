class Solution {
public:
    // The only thing we should care here is if the person gets or not get the seat.
    double nthPersonGetsNthSeat(int n) {
        return n == 1 ? 1 : 0.5;
    }
};