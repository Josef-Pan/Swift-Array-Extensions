# MySwiftArrayExtensions
Very usefaul Array Extensions which I used quite often

Examples

let array = [2, 2, 3, 8, 2, 1, 1, 1, 2, 2, 3, 7 ]

print("array = \(array), firstNonRepeatingElement() = \\(array.firstNonRepeatingElement())")

print("array = \(array), removeAdjacentDuplicates() = \\(array.removeAdjacentDuplicates())")

print("array = \(array), removeAllDuplicates() = \\(array.removeAllDuplicates())")

print("array = \(array), countUniques() = \\(array.removeAllDuplicates().count)")

print("array = \(array), removeAllDuplicatingElements() = \\(array.removeAllDuplicatingElements())")

print("array = \(array), hasDuplicates() = \\(array.hasDuplicates())")

print("[ 1, 1, 2, 2, 3].isAllGrouped() = \\([ 1, 1, 2, 2, 3].isAllGrouped())")

print("[ 2, 1, 1, 2 ].isAllGrouped()   = \\([ 2, 1, 1, 2 ].isAllGrouped())")

let combinationsOf2 = [1, 2, 3, 4].getAllCombinations().filter { $0.count == 2 }

let combinationsOf3 = [1, 2, 3, 4].getAllCombinations().filter { $0.count == 3 }

print("[1, 2, 3, 4] combinations of 2 elements = \\(combinationsOf2)")

print("[1, 2, 3, 4] combinations of 3 elements = \\(combinationsOf3)")

print("[ 3, 2, 1 ].getPermutations()   = \\([ 3, 2, 1 ].getPermutations())")

let expenses = [21.37, 9.32, 55.21,388.77, 11.42,  9.32, 10.18, 11.41,  9.32]

let subArray = [ 11.41,  9.32]

print(expenses.containsSubarray(subArray: subArray ))

