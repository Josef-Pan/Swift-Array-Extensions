import Foundation

extension Array where Element: Comparable, Element: Hashable {
    
    /// Count unique elements of Array
    /// [ 1, 3, 3, 1, 5, 7 ] -> 4
    /// - Returns: number of unique elements in array
    func countUniques() -> Int {
        return self.reduce(into: []) { result, element in
            result.contains(element) ? () : result.append(element) // Append if not in 'result'
        }.count
    }
    
    /// Remove only adjacent duplicates from Array, keeping the first occurence of duplicated elements
    /// [ 1, 3, 3, 1, 5, 7 ] -> [ 1, 3, 1, 5, 7 ]
    /// - Returns: array without adjacent duplicates
    func removeAdjacentDuplicates() -> [Element] {
        return self.reduce(into: []) { result, element in
            result.last != element ? result.append(element) : () // Append if element not equal to last one
        }
    }
    
    /// Remove only adjacent duplicates from Array, keeping the first occurence of duplicated elements
    /// [ 1, 3, 3, 1, 5, 7 ] -> [ 1, 3, 1, 5, 7 ]
    /// Unlike previous func, this function operates inplace
    mutating func removeAdjacentDuplicatesInplace(){
        var indicesToRemove = ContiguousArray<Int>() // ContiguousArray is believed to have better performance
        self.enumerated().forEach{ idx, value in
            guard idx > 0 else { return } // Search from idx == 1
            value == self[idx-1] ? indicesToRemove.append(idx) : ()
        }
        indicesToRemove.enumerated().forEach{ self.remove(at: $1 - $0 )} // value - index
    }
    
    /// Remove all duplicate elements from Array, keeping only the first occurence
    /// [ 1, 3, 3, 1, 5, 7 ] -> [ 1, 3, 5, 7 ]
    /// - Returns: array without duplicates
    func removeAllDuplicates()-> [Element] {
        return self.reduce(into: []) { result, element in
            result.contains(element) ? (): result.append(element) // Append if not in 'result'
        }
    }
    
    /// Remove all duplicate elements from Array, keeping only the first occurence
    /// [ 1, 3, 3, 1, 5, 7 ] -> [ 1, 3, 5, 7 ]
    /// Unlike previous func, this function operates inplace
    mutating func removeAllDuplicatesInplace(){
        var indicesToRemove = ContiguousArray<Int>() // ContiguousArray is believed to have better performance
        self.enumerated().forEach{ idx, value in
            guard idx > 0 else { return } // Search from idx == 1
            self[0..<(idx-1)].contains(value) ? indicesToRemove.append(idx) : ()
        }
        indicesToRemove.enumerated().forEach{ self.remove(at: $1 - $0 )} // value - index
    }
    
    /// Remove all elements that are duplicating from Array, not keeping of any occurrences of repeating elements
    /// [ 1, 3, 3, 1, 5, 7 ] -> [ 5, 7 ]
    /// - Returns: array with all non-unique elements removed
    func removeNonUniqueElements()-> [Element] {
        let counts = reduce(into: [:]){ result, element in
            result[element, default:0 ] += 1
        } // let counts = reduce(into: [:]) { $0[$1, default: 0] += 1 } // Not readable, not encouraged
        return self.filter{counts[$0, default:0] > 1}
    }
    
    /// Remove all elements that are duplicating from Array, not keeping of any occurrences of repeating elements
    /// [ 1, 3, 3, 1, 5, 7 ] -> [ 5, 7 ]
    /// Unlike previous func, this function operates inplace
    mutating func removeNonUniqueElementsInplace(){
        let counts = reduce(into: [:]){ result, element in
            result[element, default:0 ] += 1
        }
        self.removeAll(where: {counts[$0, default:0] > 1})
    }
    
    /// Test if Array has duplicates
    /// [ 1, 3, 3, 1, 5, 7 ] -> true
    /// - Returns: true if array has duplicates
    func hasDuplicates() ->Bool {
        let counts = reduce(into: [:]){ result, element in
            result[element, default:0 ] += 1
        }
        let dups =  counts.values.max() ?? 0    //Get the maximum counts of elements
        return dups > 1 ? true : false          //Duplicates should have count more than 1
    }
    
    /// Get first non repeating element from Array, may be nil
    /// [ 1, 3, 3, 1, 5, 7 ] -> Optional(5)
    /// - Returns: first non-repeating element, maybe nil
    func firstNonRepeatingElement() -> Element? {
        let counts = reduce(into: [:]){ result, element in
            result[element, default:0 ] += 1
        }
        let uique_index = self.firstIndex(where: {counts[$0] == 1})
        return uique_index == nil ? nil : self[uique_index!]
    }
    
    /// Test if same values in Array are adjacent or not, 
    /// [ 1, 1, 2, 2 ] ->true, [ 1, 1, 2, 2, 3 ] ->true, [ 2, 1, 1, 2 ] -> false
    /// - Returns: true if all grouped
    func isAllGrouped() ->Bool {
        let counts = removeAdjacentDuplicates().reduce(into: [:]){ result, element in
            result[element, default:0 ] += 1
        }
        for element in self {  // Now all elements should have count one, otherwise false
            guard let count = counts[element] else { continue }
            if count > 1 { return false }
        }
        return true
    }
    
    /// Get all combinations from Array, apply filter { $0.count ==n } to get combos of n elements
    /// ‼️This function does not remove duplicates by default
    /// Use removeAllDuplicates().getAllCombinations() to have combinations for uique elements
    /// - Returns: all combinations of the original array, note that the empty array [] is also included
    func getCombinations() ->[[Element]] {
        guard count > 0 else { return [[]] }
        let head = self[0]                      // head contains only the first element
        let tail = Array(self[1..<endIndex])    // tail contains the elements excluding the first element
        let withoutHead = tail.getCombinations() // computing the tail's powerset
        let withHead = withoutHead.map { $0 + [head] }  // merging the head with the tail's powerset
        return withHead + withoutHead   // returning the tail's powerset and the just computed withHead array
    }
    
    /// Get all permuations of an array
    /// ‼️This function does not remove duplicates by default
    /// Use removeAllDuplicates().getPermutations() to have permutations for uique elements
    /// - Returns: all permutations of the original array
    func getPermutations() ->[[Element]]  {
        guard self.count > 1 else { return [self] } // Permutation of single element array is the array itself
        var permuations:[[Element]] = []
        for (idx,value) in self.enumerated() { // element itself + permutation of other elements make up all permutations
            let otherElemets = self.enumerated().filter{ $0.offset != idx}.map{$0.element}
            let permutationOthers = otherElemets.getPermutations()   // Get permuation of other elements
            for permutation in permutationOthers {
                permuations.append( [value] + permutation )
            }
        }
        return permuations
    }
    
    /// Test if contains subarray
    /// Not fully optimised, for large array, do not use this, there are better solutions
    func containsSubarray(subArray:[Element])->Bool{
        guard subArray.count <= self.count else { return false }
        for i in 0...self.count-subArray.count{
            let slice = Array(self[i..<i+subArray.count])
            if slice == subArray { return true }
        }
        return false
    }
    
    /// Use 1D array with * to generate a 2D array
    /// [1, 3, 5] * 2 = [[1, 3, 5], [1, 3, 5]]
    /// Not fully optimized, may have better solutions
    /// - Returns: a 2D array with  rhs rows of the the original 1D array
    static func * (lhs: [Element], rhs: Int) ->[[Element]] {
        guard rhs > 0 else { return [] }
        var final:[[Element]] = []
        (0..<rhs).forEach{ $0; final.append(lhs) } // $0 has no operation, just required by forEach
        return final
    }
    
    /// Use 2D array with * to generate a 3D array
    /// [ [1, 3, 5], [1, 3, 5] ] * 2 =[ [ [1, 3, 5], [1, 3, 5] ], [ [1, 3, 5], [1, 3, 5] ] ]
    /// Not fully optimized, may have better solutions
    /// - Returns: a 3D array with  rhs layers of the the original 2D array
    static func * (lhs: [[Element]], rhs: Int) ->[[[Element]]] {
        guard rhs > 0 else { return [] }
        var final:[[[Element]]] = []
        (0..<rhs).forEach{ $0; final.append(lhs) } // $0 has no operation, just required by forEach
        return final
    }
}

extension Array  {  // let array contains() method to deal with tuple
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Equatable, E2: Equatable, Element == (E1, E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}
