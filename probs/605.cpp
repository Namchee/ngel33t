#include <vector>
using namespace std;

#define INF 1000000000

bool canPlaceFlowers(vector<int> &flowerbed, int n)
{
    int cursor = 0;

    while (cursor < flowerbed.size() && n)
    {
        bool can_place = true;
        if (flowerbed[cursor] == 1)
        {
            can_place = false;
        }

        if (
            (cursor > 0 && flowerbed[cursor - 1] == 1) ||
            (cursor < flowerbed.size() - 1 && flowerbed[cursor + 1] == 1))
        {
            can_place = false;
        }

        if (can_place)
        {
            n--;
            flowerbed[cursor] = 1;
        }

        cursor++;
    }

    return n == 0;
}
