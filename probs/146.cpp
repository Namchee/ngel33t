#include <unordered_map>
using namespace std;

class Node {
public:
    int key, value;
    Node* prev;
    Node* next;

    Node(int key, int value) {
        this->key = key;
        this->value = value;

        this->prev = nullptr;
        this->next = nullptr;
    }
};

class LRUCache {
public:
    LRUCache(int capacity) {
        this->cap = capacity;
        this->mp.clear();

        this->left = new Node(0, 0);
        this->right = new Node(0, 0);

        this->left->next = this->right;
        this->right->prev = this->left;
    }
    
    int get(int key) {
        if (this->mp.find(key) == this->mp.end()) {
            return -1;
        }

        Node* node = this->mp[key];
        this->remove(node);
        this->insert(node);

        return node->value;
    }
    
    void put(int key, int value) {
        if (this->mp.find(key) != this->mp.end()) {
            this->remove(this->mp[key]);
        }

        Node* newNode = new Node(key, value);
        this->mp[key] = newNode;
        this->insert(newNode);

        if (this->mp.size() > this->cap) {
            Node* least = this->left->next;
            this->remove(least);
            this->mp.erase(least->key);

            delete least;
        }
    }

private:
    int cap;
    unordered_map<int, Node*> mp;
    Node* left;
    Node* right;

    void remove(Node* node) {
        Node* prev = node->prev;
        Node* next = node->next;
        prev->next = next;
        next->prev = prev;
    }

    void insert(Node* node) {
        Node* prev = right->prev;
        prev->next = node;
        node->prev = prev;
        node->next = right;
        right->prev = node;
    }
};
