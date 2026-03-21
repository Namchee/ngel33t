package main

func partition(head *ListNode, x int) *ListNode {
	beforeDummy := &ListNode{}
	before := beforeDummy
	afterDummy := &ListNode{}
	after := afterDummy

	for head != nil {
		if head.Value < x {
			before.Next = head
			before = before.Next
		} else {
			after.Next = head
			after = after.Next
		}

		head = head.Next
	}

	after.Next = nil
	before.Next = afterDummy.Next

	return beforeDummy.Next
}
