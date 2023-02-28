#include <string>
using namespace std;

string categorizeBox(int length, int width, int height, int mass)
{
    unsigned long long vol = (unsigned long long)length * (unsigned long long)width * (unsigned long long)height;

    bool isBulky = length >= 10000 || width >= 10000 || height >= 10000 || vol >= 1000000000;

    bool isHeavy = mass >= 100;

    if (isBulky && isHeavy)
    {
        return "Both";
    }

    if (!isBulky && !isHeavy)
    {
        return "Neither";
    }

    if (isBulky && !isHeavy)
    {
        return "Bulky";
    }

    return "Heavy";
}