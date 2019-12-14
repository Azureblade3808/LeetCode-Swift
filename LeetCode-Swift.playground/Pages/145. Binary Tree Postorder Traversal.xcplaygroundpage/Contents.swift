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
	private enum Step {
		case left
		case right
		case over
	}
	
	func postorderTraversal(_ root: TreeNode?) -> [Int] {
		var result: [Int] = []
		
		if let root = root {
			var current: (node: TreeNode, step: Step) = (root, .left)
			var previousPath: [(node: TreeNode, step: Step)] = []
			
			while true {
				if current.step == .left {
					current.step = .right
					
					if let leftNode = current.node.left {
						previousPath.append(current)
						current = (leftNode, .left)
						continue
					}
				}
				
				if current.step == .right {
					current.step = .over
					
					if let rightNode = current.node.right {
						previousPath.append(current)
						current = (rightNode, .left)
						continue
					}
				}
				
				result.append(current.node.val)
				
				if previousPath.isEmpty {
					break
				}
				
				current = previousPath.removeLast()
			}
		}
		
		return result;
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

print("OK")

//: [Next](@next)
