//: [Previous](@previous)

class Solution {
	func cherryPickup(_ grid: [[Int]]) -> Int {
		assert(1 ... 50 ~= grid.count)
		assert(grid[0][0] >= 0)
		assert(grid[grid.count - 1][grid.count - 1] >= 0)
		
		let size = grid.count
		
		func calculateBestResult(
			_ rowIndex: Int,
			_ previousPartialBestResult: Int,
			_ previousLeftColumnIndex: Int,
			_ previousRightColumnIndex: Int
		) -> Int {
			assert(0 ..< size ~= rowIndex)
			
			assert(0 <= previousLeftColumnIndex)
			assert(previousLeftColumnIndex <= previousRightColumnIndex)
			assert(previousRightColumnIndex < size)
			
			let row = grid[rowIndex]
			let nextRowIndex = rowIndex + 1
			
			if nextRowIndex == size {
				// It's the last row. We should try to close the route.
				
				var bestResult = previousPartialBestResult
				
				// Add all values referenced in current row.
				// The line starts at `previousLeftColumnIndex` and ends before `size`.
				for columnIndex in previousLeftColumnIndex ..< size {
					let value = row[columnIndex]
					if value < 0 {
						// There is some obstacle in the way, so the route is invalid.
						return 0
					}
					
					bestResult += value
				}
				
				return bestResult
			}
			
			var bestResult = 0
			
			for leftColumnIndex in previousLeftColumnIndex ... previousRightColumnIndex {
				LOOP_RIGHT_COLUMN_INDEX:
				for rightColumnIndex in previousRightColumnIndex ..< size {
					var partialBestResult = previousPartialBestResult
					
					// Add all values referenced in current row.
					do {
						if leftColumnIndex == previousRightColumnIndex {
							// The line is closed and starts at `previousLeftColumnIndex`
							// and ends at `rightColumnIndex`
							for columnIndex in previousLeftColumnIndex ... rightColumnIndex {
								let value = row[columnIndex]
								if value < 0 {
									// There is some obstacle in the way, so the route is invalid.
									break LOOP_RIGHT_COLUMN_INDEX
								}
								partialBestResult += value
							}
						}
						else {
							// The line is separated into two parts.
							// The first part starts at 'previousLeftColumnIndex`
							// and ends at `leftColumnIndex`.
							// The second part starts at `previousRightColumnIndex`
							// and ends at `rightColumnIndex`.
							for columnIndex in previousLeftColumnIndex ... leftColumnIndex {
								let value = row[columnIndex]
								if value < 0 {
									// There is some obstacle in the way, so the route is invalid.
									break LOOP_RIGHT_COLUMN_INDEX
								}
								partialBestResult += value
							}
							for columnIndex in previousRightColumnIndex ... rightColumnIndex {
								let value = row[columnIndex]
								if value < 0 {
									// There is some obstacle in the way, so the route is invalid.
									break LOOP_RIGHT_COLUMN_INDEX
								}
								partialBestResult += value
							}
						}
					}
					
					let tempBestResult = calculateBestResult(nextRowIndex, partialBestResult, leftColumnIndex, rightColumnIndex)
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
assert(cherryPickup([[1, 1, 1, 1, 1], [1, 1, -1, 1, 1], [-1, -1, 1, 1, 1], [1, 1, 1, 1, 1], [-1, 1, 1, 1, 1]]) == 13)

print("OK")

//: [Next](@next)
