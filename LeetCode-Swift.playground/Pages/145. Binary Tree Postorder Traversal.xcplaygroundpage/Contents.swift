//: [Previous](@previous)

public class TreeNode {
	public var val: Int
	public var left: TreeNode?
	public var right: TreeNode?
	public init(_ val: Int) {
		self.val = val
		self.left = nil
		self.right = nil
	}
}

class Solution {
	func postorderTraversal(_ root: TreeNode?) -> [Int] {
		// FIXME: ...
		fatalError()
	}
}


extension TreeNode {
	convenience init(_ val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
		self.init(val)
		
		self.left = left
		self.right = right
	}
}

assert(
	Solution().postorderTraversal(
		TreeNode(
			1,
			right: TreeNode(
				2,
				left: TreeNode(3)
			)
		)
	)
	
	==
	
	[3, 2, 1]
)

//: [Next](@next)
