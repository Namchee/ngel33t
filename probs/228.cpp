#include <vector>
#include <sstream>
#include <string>
using namespace std;

vector<string> summaryRanges(vector<int> &nums)
{
    vector<string> result;
    vector<int> temp;

    for (int i = 0; i < nums.size(); i++)
    {
        if (
            !temp.empty() &&
            temp[temp.size() - 1] + 1 != nums[i])
        {
            string notation = get_arrow_notation(temp);
            result.push_back(notation);
        }

        temp.push_back(nums[i]);
    }

    if (!temp.empty())
    {
        string notation = get_arrow_notation(temp);
        result.push_back(notation);
    }

    return result;
}

string get_arrow_notation(vector<int> &temp)
{
    int first = temp[0];
    int last = temp[temp.size() - 1];

    ostringstream oss;
    oss << first;

    if (last != first)
    {
        oss << "->" << last;
    }

    temp.clear();
    return oss.str();
}