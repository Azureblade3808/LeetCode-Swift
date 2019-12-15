//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		assert(1 ... 50 ~= grid.count)
		assert(grid[0][0] >= 0)
		assert(grid[grid.count - 1][grid.count - 1] >= 0)
		
		let size = grid.count
		
		func calculateBestResult(
			_ rowIndex: Int,
			_ previousBestPartialResult: Int,
			_ previousLeftColumnIndex: Int,
			_ previousRightColumnIndex: Int
		) -> Int {
			assert(0 ... size ~= rowIndex)
			
			assert(0 <= previousLeftColumnIndex)
			assert(previousLeftColumnIndex <= previousRightColumnIndex)
			assert(previousRightColumnIndex < size)
			
			guard rowIndex < size else {
				return previousBestPartialResult
			}
			
			let row = grid[rowIndex]
			let nextRowIndex = rowIndex + 1
			
			var bestResult = 0
			
			for leftColumnIndex in previousLeftColumnIndex ... previousRightColumnIndex {
				LOOP_RIGHT_COLUMN_INDEX:
				for rightColumnIndex in previousRightColumnIndex ..< size {
					var bestPartialResult = previousBestPartialResult
					// Add all values referenced in current row.
					for columnIndex in leftColumnIndex ... rightColumnIndex {
						let value = row[columnIndex]
						if value < 0 {
							break LOOP_RIGHT_COLUMN_INDEX
						}
						bestPartialResult += value
					}
					
					let tempBestResult = calculateBestResult(nextRowIndex, bestPartialResult, leftColumnIndex, rightColumnIndex)
					if tempBestResult > bestResult {
						bestResult = tempBestResult
					}
				}
			}
			
			return bestResult
		}
		
		let bestResult = calculateBestResult(0, 0, 0, 0)
		return bestResult
	}
}

let cherryPickup = Solution().cherryPickup
assert(cherryPickup([[0, 1, -1], [1, 0, -1], [1, 1,  1]]) == 5)
assert(cherryPickup([[1, 1, -1], [1, -1, 1], [-1, 1, 1]]) == 0)
assert(cherryPickup([[1, -1, -1, -1, -1], [1, 0, 1, -1, -1], [0, -1, 1, 0, 1], [1, 0, 1, 1, 0], [-1, -1, -1, 1, 1]]) == 10)

print("OK")

//: [Next](@next)
