//: [Previous](@previous)

class Solution {
	func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
		let height = dungeon.count
		assert(height > 0)
		
		let firstRow = dungeon[0]
		let width = firstRow.count
		assert(width > 0)
		
		let lastColumnIndex = width - 1
		let lastRowIndex = height - 1

		var damageThresholdsForLatestRow: [Int]
		
		// Deal with the last row.
		do {
			let row = dungeon[lastRowIndex]
			
			var damageThresholds = Array(repeating: 0, count: width)
			var damageThresholdForLatestGrid: Int
			
			// Deal with the last column.
			do {
				let value = row[lastColumnIndex]
				
				let damageThreshold = min(value, 0)
				damageThresholds[lastColumnIndex] = damageThreshold
				
				damageThresholdForLatestGrid = damageThreshold
			}
			
			// Deal with the rest columns.
			for columnIndex in (0 ..< lastColumnIndex).reversed() {
				let value = row[columnIndex]
				
				let damageThreshold = min(
					value + damageThresholdForLatestGrid,
					0
				)
				damageThresholds[columnIndex] = damageThreshold
				
				damageThresholdForLatestGrid = damageThreshold
			}
			
			damageThresholdsForLatestRow = damageThresholds
		}
		
		// Deal with the rest rows.
		for rowIndex in (0 ..< lastRowIndex).reversed() {
			let row = dungeon[rowIndex]
			
			var damageThresholds = Array(repeating: 0, count: width)
			var damageThresholdForLatestGrid: Int
			
			// Deal with the last column.
			do {
				let value = row[lastColumnIndex]
				
				let damageThresholdForGridAtBelow = damageThresholdsForLatestRow[lastColumnIndex]
				
				let damageThreshold = min(value + damageThresholdForGridAtBelow, 0)
				damageThresholds[lastColumnIndex] = damageThreshold
				
				damageThresholdForLatestGrid = damageThreshold
			}
			
			// Deal with the rest columns.
			for columnIndex in (0 ..< lastColumnIndex).reversed() {
				let value = row[columnIndex]
				
				let damageThresholdForGridAtRight = damageThresholdForLatestGrid
				let damageThresholdForGridAtBelow = damageThresholdsForLatestRow[columnIndex]
				
				let damageThreshold = min(value + max(damageThresholdForGridAtRight, damageThresholdForGridAtBelow), 0)
				damageThresholds[columnIndex] = damageThreshold
				
				damageThresholdForLatestGrid = damageThreshold
			}
			
			damageThresholdsForLatestRow = damageThresholds
		}
		
		let damageThreshold = damageThresholdsForLatestRow[0]
		let minimumHp = 1 - damageThreshold
		
		return minimumHp
	}
}

let calculateMinimumHP = Solution().calculateMinimumHP
assert(calculateMinimumHP([[-2, -3, 3], [-5, -10, 1], [10, 30, -5]]) == 7)
assert(calculateMinimumHP([[1, 2, 1], [-2, -3, -3], [3, 2, -2]]) == 1)

print("OK")

//: [Next](@next)
