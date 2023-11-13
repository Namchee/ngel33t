class Solution {
public:
    string sortVowels(string s) {
        int len = 0;
        int start = 0;
        vector<pair<int, int> > poi;
        vector<char> vowels;

        bool processing = false;

        for (int idx = 0; idx < s.size(); idx++) {
            bool vowel = isVowel(s[idx]);

            if (vowel) {
                if (processing) {
                    len++;
                } else {
                    processing = true;
                    start = idx;
                    len = 1;
                }

                vowels.push_back(s[idx]);
            } else {
                if (processing) {
                    processing = false;
                    poi.push_back({ start, len });
                }
            }
        }

        if (processing) {
            poi.push_back({ start, len });
        }

        int vIdx = 0;

        sort(vowels.begin(), vowels.end());
        for (int idx = 0; idx < poi.size(); idx++) {
            int len = poi[idx].second;
            int start = poi[idx].first;

            while (len--) {
                s[start++] = vowels[vIdx++];
            }
        }

        return s;
    }

    bool isVowel(char c) {
        char low = tolower(c);

        return low == 'a' || low == 'i' || low == 'u' || low == 'e' || low == 'o';
    }
};
