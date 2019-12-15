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
			var damageThresholdForLatestCell: Int
			
			// Deal with the last column.
			do {
				let value = row[lastColumnIndex]
				
				let damageThreshold = min(value, 0)
				damageThresholds[lastColumnIndex] = damageThreshold
				
				damageThresholdForLatestCell = damageThreshold
			}
			
			// Deal with the rest columns.
			for columnIndex in (0 ..< lastColumnIndex).reversed() {
				let value = row[columnIndex]
				
				let damageThreshold = min(
					value + damageThresholdForLatestCell,
					0
				)
				damageThresholds[columnIndex] = damageThreshold
				
				damageThresholdForLatestCell = damageThreshold
			}
			
			damageThresholdsForLatestRow = damageThresholds
		}
		
		// Deal with the rest rows.
		for rowIndex in (0 ..< lastRowIndex).reversed() {
			let row = dungeon[rowIndex]
			
			var damageThresholds = Array(repeating: 0, count: width)
			var damageThresholdForLatestCell: Int
			
			// Deal with the last column.
			do {
				let value = row[lastColumnIndex]
				
				let damageThresholdForCellAtBelow = damageThresholdsForLatestRow[lastColumnIndex]
				
				let damageThreshold = min(value + damageThresholdForCellAtBelow, 0)
				damageThresholds[lastColumnIndex] = damageThreshold
				
				damageThresholdForLatestCell = damageThreshold
			}
			
			// Deal with the rest columns.
			for columnIndex in (0 ..< lastColumnIndex).reversed() {
				let value = row[columnIndex]
				
				let damageThresholdForCellAtRight = damageThresholdForLatestCell
				let damageThresholdForCellAtBelow = damageThresholdsForLatestRow[columnIndex]
				
				let damageThreshold = min(value + max(damageThresholdForCellAtRight, damageThresholdForCellAtBelow), 0)
				damageThresholds[columnIndex] = damageThreshold
				
				damageThresholdForLatestCell = damageThreshold
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
