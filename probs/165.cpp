#include <vector>
#include <string>
#include <sstream>
#include <iostream>
using namespace std;

class Solution {
public:
    int compareVersion(string version1, string version2) {
        vector<int> a = getTokens(version1);
        vector<int> b = getTokens(version2);

        while (a.size() < b.size()) {
            a.push_back(0);
        }
        while (b.size() < a.size()) {
            b.push_back(0);
        }

        for (int i = 0; i < a.size(); i++) {
            if (a[i] != b[i]) {
                return a[i] > b[i] ? 1 : -1;
            }
        }

        return 0;
    }

private:
    vector<int> getTokens(string ver) {
        istringstream iss(ver);
        vector<int> tokens;
        string token;
        while (getline(iss, token, '.')) {
            if (!token.empty())
                tokens.push_back(stoi(token));    
        }

        return tokens;
    } 
};
