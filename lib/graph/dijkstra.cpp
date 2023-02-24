#include <iostream>
#include <vector>
#include <queue>
#include <utility>
using namespace std;

#define INF 1000000000

vector<vector<pair<int, int>>> adj;
vector<int> dist;

void make_pair(int a, int b, int w)
{
    adj[a].push_back({b, w});
    adj[b].push_back({a, w});
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    adj.resize(9, vector<pair<int, int>>());
    dist.resize(9, INF);

    make_pair(0, 1, 4);
    make_pair(0, 7, 8);
    make_pair(1, 2, 8);
    make_pair(1, 7, 11);
    make_pair(2, 3, 7);
    make_pair(2, 8, 2);
    make_pair(2, 5, 4);
    make_pair(3, 4, 9);
    make_pair(3, 5, 14);
    make_pair(4, 5, 10);
    make_pair(5, 6, 2);
    make_pair(6, 7, 1);
    make_pair(6, 8, 6);
    make_pair(7, 8, 7);

    /*
    int n, a, b, w, start;
    cin >> n;



    while (true)
    {
        cin >> a >> b >> w;

        if (a == 0 || b == 0)
        {
            break;
        }

        adj[a].push_back({b, w});
    }

    cin >> start;
    */

    priority_queue<pair<int, int>>
        pq;
    dist[0] = 0;

    pq.push({dist[0], 0});

    while (!pq.empty())
    {
        pair<int, int> curr = pq.top();
        pq.pop();

        int node = curr.second;

        for (int idx = 0; idx < adj[node].size(); idx++)
        {
            int target = adj[node][idx].first;
            int cost = adj[node][idx].second;

            if (dist[target] > dist[node] + cost)
            {
                dist[target] = dist[node] + cost;
                pq.push({dist[target], target});
            }
        }
    }

    for (int idx = 0; idx < dist.size(); idx++)
    {
        cout << 0 << " -> " << idx << ": " << dist[idx] << "\n";
    }

    return 0;
}