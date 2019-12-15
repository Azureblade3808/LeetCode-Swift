//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		assert(1 ... 50 ~= grid.count)
		assert(grid[0][0] >= 0)
		assert(grid[grid.count - 1][grid.count - 1] >= 0)
		
		let size = grid.count
		let maxIndex = size - 1
		
		func calculateForwards(_ grid: [[Int]], _ x: Int, _ y: Int) -> Int {
			let value = grid[y][x]
			if value < 0 {
				return -1
			}
			
			var grid = grid
			grid[y][x] = 0
			
			if x < maxIndex {
				if y < maxIndex {
					let resultRightwards = calculateForwards(grid, x + 1, y)
					let resultDownwards = calculateForwards(grid, x, y + 1)
					let resultRightwardsOrDownwards = max(resultRightwards, resultDownwards)
					if resultRightwardsOrDownwards < 0 {
						return -1
					}
					
					let result = value + resultRightwardsOrDownwards
					return result
				}
				else {
					let resultRightwards = calculateForwards(grid, x + 1, y)
					if resultRightwards < 0 {
						return -1
					}
					
					let result = value + resultRightwards
					return result
				}
			}
			else {
				if y < maxIndex {
					let resultDownwards = calculateForwards(grid, x, y + 1)
					if resultDownwards < 0 {
						return -1
					}
					
					let result = value + resultDownwards
					return result
				}
				else {
					let resultBackwards = calculateBackwards(grid, x, y)
					assert(resultBackwards >= 0)
					
					let result = value + resultBackwards
					return result
				}
			}
		}
		
		func calculateBackwards(_ grid: [[Int]], _ x: Int, _ y: Int) -> Int {
			let value = grid[y][x]
			if value < 0 {
				return -1
			}
			
			if x > 0 {
				if y > 0 {
					let resultLeftwards = calculateBackwards(grid, x - 1, y)
					let resultUpwards = calculateBackwards(grid, x, y - 1)
					let resultLeftwardsOrUpwards = max(resultLeftwards, resultUpwards)
					if resultLeftwardsOrUpwards < 0 {
						return -1
					}
					
					let result = value + resultLeftwardsOrUpwards
					return result
				}
				else {
					let resultLeftwards = calculateBackwards(grid, x - 1, y)
					if resultLeftwards < 0 {
						return -1
					}
					
					let result = value + resultLeftwards
					return result
				}
			}
			else {
				if y > 0 {
					let resultUpwards = calculateBackwards(grid, x, y - 1)
					if resultUpwards < 0 {
						return -1
					}
					
					let result = value + resultUpwards
					return result
				}
				else {
					assert(value == 0)
					return 0
				}
			}
		}
		
		let result = calculateForwards(grid, 0, 0)
		if result < 0 {
			return 0
		}
		
		return result
	}
}

let cherryPickup = Solution().cherryPickup
assert(cherryPickup([[0, 1, -1], [1, 0, -1], [1, 1,  1]]) == 5)
assert(cherryPickup([[1, 1, -1], [1, -1, 1], [-1, 1, 1]]) == 0)

print("OK")

//: [Next](@next)
