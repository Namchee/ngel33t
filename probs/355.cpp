#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>
using namespace std;

class Twitter {
public:
    Twitter() {
        idx = 0;
    }
    
    void postTweet(int userId, int tweetId) {
        this->tweets[userId].push_back({ idx++, tweetId });
        idx++;
    }
    
    vector<int> getNewsFeed(int userId) {
        vector<int> result;

        priority_queue<pair<int, int> > temp;
        bool selfFollow = false;

        for (int person: feed[userId]) {
            for (pair<int, int> tweet: tweets[person]) {
                temp.push(tweet);
            }

            if (person == userId) {
                selfFollow = true;
            }
        }

        if (!selfFollow) {
            for (pair<int, int> tweet: tweets[userId]) {
                temp.push(tweet);
            }
        }

        while (temp.size() && result.size() < 10) {
            result.push_back(temp.top().second);
            temp.pop();
        }

        return result;
    }
    
    void follow(int followerId, int followeeId) {
        this->feed[followerId].insert(followeeId);
    }
    
    void unfollow(int followerId, int followeeId) {
        this->feed[followerId].erase(followeeId);
    }

private:
    int idx;
    unordered_map<int, vector<pair<int, int> > > tweets;
    unordered_map<int, unordered_set<int> > feed;
};
