#include <string>
#include <sstream>
using namespace std;

int strStr(string haystack, string needle)
{
    size_t idx = haystack.find(needle);
    if (idx != string::npos)
    {
        return idx;
    }

    return -1;
}