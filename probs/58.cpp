#include <string>
#include <sstream>
using namespace std;

int lengthOfLastWord(string s)
{
    string temp;
    stringstream ss(s);

    int result = 0;

    while (ss >> temp)
    {
        result = temp.length();
    }

    return result;
}