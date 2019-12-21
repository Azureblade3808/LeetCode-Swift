//: [Previous](@previous)

class Solution {
	func findMin(_ numbers: [Int]) -> Int {
		assert(numbers.count != 0)
		
		let length = numbers.count
		let firstNumber = numbers[0]
		
		if length == 1 {
			return firstNumber
		}
		
		var index = 0
		var number = firstNumber
		
		while true {
			var nextIndex = index + 1
			if nextIndex == length {
				return firstNumber
			}
			
			var nextNumber = numbers[nextIndex]
			if nextNumber < number {
				return nextNumber
			}
			
			index = nextIndex
			number = nextNumber
		}
	}
}

let findMin = Solution().findMin
assert(findMin([1,3,5]) == 1)
assert(findMin([2,2,2,0,1] == 0)

print("OK")

//: [Next](@next)
