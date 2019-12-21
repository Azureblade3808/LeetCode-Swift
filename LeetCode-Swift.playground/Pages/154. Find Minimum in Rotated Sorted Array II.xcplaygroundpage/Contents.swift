//: [Previous](@previous)

class Solution {
	func findMin(_ numbers: [Int]) -> Int {
		assert(numbers.count != 0)
		
		let length = numbers.count
		if length == 1 {
			return numbers[0]
		}
		
		let lengthMinusOne = length - 1
		
		func calculateResult(_ leftIndex: Int, _ rightIndex: Int, _ leftNumber: Int, _ rightNumber: Int, _ diff: Int) -> Int? {
			assert(leftIndex < rightIndex)
			assert(leftNumber == numbers[leftIndex])
			assert(rightNumber == numbers[rightIndex])
			assert(diff == rightIndex - leftIndex)
			assert(diff >= 1)
			
			if diff == 1 {
				if leftNumber > rightNumber {
					return rightNumber
				}
				else {
					return nil
				}
			}
			else {
				let centerIndex = (leftIndex + rightIndex) / 2
				let centerNumber = numbers[centerIndex]
				
				if leftNumber > centerNumber {
					return calculateResult(leftIndex, centerIndex, leftNumber, centerNumber, centerIndex - leftIndex)
				}
				
				if centerNumber > rightNumber {
					return calculateResult(centerIndex, rightIndex, centerNumber, rightNumber, rightIndex - centerIndex)
				}
				
				return (
					calculateResult(leftIndex, centerIndex, leftNumber, centerNumber, centerIndex - leftIndex)
					??
					calculateResult(centerIndex, rightIndex, centerNumber, rightNumber, rightIndex - centerIndex)
				)
			}
		}
		
		let firstNumber = numbers[0]
		let lastNumber = numbers[lengthMinusOne]
		
		let result = calculateResult(0, lengthMinusOne, firstNumber, lastNumber, lengthMinusOne) ?? firstNumber
		
		return result
	}
}

let findMin = Solution().findMin
assert(findMin([1,3,5]) == 1)
assert(findMin([2,2,2,0,1] == 0)

print("OK")

//: [Next](@next)
