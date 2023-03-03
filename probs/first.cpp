#include <string>
#include <iostream>
using namespace std;

int hamming_distance(unsigned long long num)
{
    int count = 0;
    while (num)
    {
        count += num & 1;
        num >>= 1;
    }

    return count;
}

string hitung(string bilangan)
{
    unsigned long long num = stoi(bilangan);
    unsigned long long res = 0;

    int num_of_one = hamming_distance(num);

    while (num)
    {
        res = (res << 1) + (num_of_one > 0 ? 1 : 0);

        num_of_one--;
        num >>= 1;
    }

    return to_string(res);
}

int main()
{
    string N_temp;
    getline(cin, N_temp);

    int N = stoi(N_temp);

    for (int N_itr = 0; N_itr < N; N_itr++)
    {
        string M;
        getline(cin, M);

        string X = hitung(M);

        cout << X << "\n";
    }

    return 0;
}