#include <vector>
#include <iostream>
using namespace std;

vector<vector<int>> generate(int numRows)
{
    vector<vector<int>> result;
    result.push_back(
        {1});

    if (numRows > 1)
    {
        result.push_back(
            {1, 1});
    }

    for (int row = 2; row < numRows; row++)
    {
        vector<int> r(row + 1, 1);

        for (int i = 1; i < r.size() - 1; i++)
        {
            r[i] = result[row - 1][i - 1] + result[row - 1][i];
        }

        result.push_back(r);
    }

    return result;
}

int main()
{
    int dim;

    cin >> dim;
    vector<vector<int>> r = generate(dim);

    for (int i = 0; i < r.size(); i++)
    {
        for (int j = 0; j < r[i].size(); j++)
        {
            cout << r[i][j] << " ";
        }

        cout << "\n";
    }
    return 0;
}