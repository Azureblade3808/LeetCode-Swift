//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		assert(1 ... 50 ~= grid.count)
		assert(grid[0][0] >= 0)
		assert(grid[grid.count - 1][grid.count - 1] >= 0)
		
		// FIXME: ...
		fatalError()
	}
}

let cherryPickup = Solution().cherryPickup
assert(cherryPickup([[0, 1, -1], [1, 0, -1], [1, 1,  1]]) == 5)
assert(cherryPickup([[1, 1, -1], [1, -1, 1], [-1, 1, 1]]) == 0)

print("OK")

//: [Next](@next)
