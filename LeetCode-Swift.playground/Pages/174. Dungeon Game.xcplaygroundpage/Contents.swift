//: [Previous](@previous)

class Solution {
	func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
		let height = dungeon.count
		
		let firstRow = dungeon[0]
		let width = firstRow.count
		
		func calculateDeepestDamageOfSafestRoute(
			_ x: Int,
			_ y: Int,
			_ previousTotalValue: Int
		) -> Int {
			let value = dungeon[y][x]
			let totalValue = previousTotalValue + value
			
			var deepestDamageOfSafestRoute = min(totalValue, 0)
			
			if x < width - 1 {
				if y < height - 1 {
					let deepestDamageOfSafestRouteFromRightwards = calculateDeepestDamageOfSafestRoute(x + 1, y, totalValue)
					let deepestDamageOfSafestRouteFromDownwards = calculateDeepestDamageOfSafestRoute(x, y + 1, totalValue)
					let deepestDamageOfSafestRouteFromNext = max(
						deepestDamageOfSafestRouteFromRightwards,
						deepestDamageOfSafestRouteFromDownwards
					)
					if deepestDamageOfSafestRouteFromNext < deepestDamageOfSafestRoute {
						deepestDamageOfSafestRoute = deepestDamageOfSafestRouteFromNext
					}
				}
				else {
					let deepestDamageOfSafestRouteFromRightwards = calculateDeepestDamageOfSafestRoute(x + 1, y, totalValue)
					if deepestDamageOfSafestRouteFromRightwards < deepestDamageOfSafestRoute {
						deepestDamageOfSafestRoute = deepestDamageOfSafestRouteFromRightwards
					}
				}
			}
			else {
				if y < height - 1 {
					let deepestDamageOfSafestRouteFromDownwards = calculateDeepestDamageOfSafestRoute(x, y + 1, totalValue)
					if deepestDamageOfSafestRouteFromDownwards < deepestDamageOfSafestRoute {
						deepestDamageOfSafestRoute = deepestDamageOfSafestRouteFromDownwards
					}
				}
				else {
					// Do nothing.
				}
			}
			
			return deepestDamageOfSafestRoute
		}
		
		let deepestDamageOfSafestRoute = calculateDeepestDamageOfSafestRoute(0, 0, 0)
		let minimumHp = 1 - deepestDamageOfSafestRoute
		
		return minimumHp
	}
}

let calculateMinimumHP = Solution().calculateMinimumHP
assert(calculateMinimumHP([[-2, -3, 3], [-5, -10, 1], [10, 30, -5]]) == 7)

print("OK")

//: [Next](@next)
