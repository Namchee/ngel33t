#include <vector>
#include <string>
using namespace std;

class Solution
{
public:
    int matrixScore(vector<vector<int>> &grid)
    {
        int result = 0;

        for (int i = 0; i < grid.size(); i++)
        {
            if (grid[i][0] == 0)
            {
                toggleRow(grid, i);
            }
        }

        for (int i = 0; i < grid[0].size(); i++)
        {
            int temp = 0;

            for (int j = 0; j < grid.size(); j++)
            {
                temp += grid[j][i];
            }

            if ((grid.size() - temp) > temp)
            {
                toggleColumn(grid, i);
            }
        }

        for (int i = 0; i < grid.size(); i++)
        {
            string temp = "";

            for (int j = 0; j < grid[i].size(); j++)
            {
                temp += grid[i][j] + '0';
            }

            result += stoi(temp, nullptr, 2);
        }

        return result;
    }

private:
    void toggleRow(vector<vector<int>> &grid, int row)
    {
        for (int i = 0; i < grid[row].size(); i++)
        {
            grid[row][i] ^= 1;
        }
    }

    void toggleColumn(vector<vector<int>> &grid, int col)
    {
        for (int i = 0; i < grid.size(); i++)
        {
            grid[i][col] ^= 1;
        }
    }
};