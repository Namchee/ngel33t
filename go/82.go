package main

type ListNode struct {
	Value int
	Next  *ListNode
}

func deleteDuplicates(head *ListNode) *ListNode {
	bucket := make([]int, 201)

	walker := head
	for walker != nil {
		bucket[walker.Value+100]++
		walker = walker.Next
	}

	dummy := &ListNode{}
	walker = dummy

	for idx, count := range bucket {
		if count == 1 {
			walker.Next = &ListNode{
				Value: idx - 100,
			}

			walker = walker.Next
		}
	}

	return dummy.Next
}
