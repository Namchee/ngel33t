#include <vector>
#include <unordered_map>
using namespace std;

bool checkIfExist(vector<int> &arr)
{
    unordered_map<int, int> mp;
    for (int i = 0; i < arr.size(); i++)
    {
        mp[arr[i]] = i;
    }

    for (int i = 0; i < arr.size(); i++)
    {
        int search = arr[i] * 2;
        if (mp.find(search) != mp.end() && mp[search] != i)
        {
            return true;
        }
    }

    return false;
}