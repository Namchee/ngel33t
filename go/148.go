package main

// type ListNode struct {
// 	Val  int
// 	Next *ListNode
// }

func mergeSort(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	tortoise := head
	hare := head.Next

	for hare != nil && hare.Next != nil {
		tortoise = tortoise.Next
		hare = hare.Next.Next
	}

	mid := tortoise.Next
	tortoise.Next = nil

	left := mergeSort(head)
	right := mergeSort(mid)

	dummy := &ListNode{Val: -1}

	walker := dummy

	for left != nil && right != nil {
		if left.Val <= right.Val {
			walker.Next = left
			left = left.Next
		} else {
			walker.Next = right
			right = right.Next
		}
		walker = walker.Next
	}

	if left != nil {
		walker.Next = left
	}
	if right != nil {
		walker.Next = right
	}

	return dummy.Next
}

func sortList(head *ListNode) *ListNode {
	return mergeSort(head)
}
