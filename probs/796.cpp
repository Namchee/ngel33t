#include <string>
using namespace std;

bool rotateString(string s, string goal)
{
    return s.length() == goal.length() && (s + s).find(goal) != string::npos;
}