import UIKit
extension Array where Element: Comparable, Element: Hashable {
    /// Count unique elements of Array
    func countUniques() -> Int {
        return self.removeAllDuplicates().count
    }
    /// Remove only adjacent duplicates from Array, keeping the first occurence
    func removeAdjacentDuplicates() -> [Element] {
        return reduce(into: []) { total, element in
            total.last != element ? total.append(element) :()
        }
    }
    /// Remove all duplicate elements from Array, keeping only the first occurence
    func removeAllDuplicates()-> [Element] {
        return reduce(into: []) { total, element in
            total.contains(element) ? (): total.append(element)
        }
    }
    /// Remove all elements that are duplicating from Array, not keeping of any occurrences of repeating elements
    func removeAllDuplicatingElements()-> [Element] {
        let counts = reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        } // let counts = reduce(into: [:]) { $0[$1, default: 0] += 1 } // Not readable, not encouraged
        return filter{ element in
            guard let count = counts[element] else { return false}
            return count>1 ? false : true    // Element with occurrences more than 1 are duplicating
        }
    }
    /// Test if Array has duplicates
    func hasDuplicates() ->Bool {
        let counts = reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        }
        guard let dups =  counts.values.max() else { return false }     //Get the maximum counts of elements
        return dups > 1 ? true : false                                  //Duplicates should have count more than 1
    }
    /// Get first non repeating element from Array, may be nil
    func firstNonRepeatingElement() -> Element? {
        let counts = reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        }
        for element in self {
            guard let count = counts[element] else { continue }
            if count == 1 { return element }
        }
        return nil
    }
    /// Test if same values in Array are adjacent or not, [ 1, 1, 2, 2 ] ->true, [ 1, 1, 2, 2, 3 ] ->true, [ 2, 1, 1, 2 ] -> false
    func isAllGrouped() ->Bool {
        let counts = removeAdjacentDuplicates().reduce(into: [:]){ total, element in
            total[element, default:0 ] += 1
        }
        for element in self {  // Now all elements should have count one, otherwise false
            guard let count = counts[element] else { continue }
            if count > 1 { return false }
        }
        return true
    }
    /// Get all combinations from Array, apply filter { $0.count ==n } to get combos of n elements
    func getAllCombinations() ->[[Element]] {
        guard count > 0 else { return [[]] }
        let tail = Array(self[1..<endIndex])    // tail contains the elements excluding the first element
        let head = self[0]                      // head contains only the first element
        let withoutHead = tail.getAllCombinations() // computing the tail's powerset
        let withHead = withoutHead.map { $0 + [head] }  // merging the head with the tail's powerset
        return withHead + withoutHead   // returning the tail's powerset and the just computed withHead array
    }
    /// Get all permuations of an array
    func getPermutations() ->[[Element]]  {
        guard self.count > 1 else { return [self] } // Permutation of single element array is the array itself
        var permuations:[[Element]] = []
        for tuple in self.enumerated() { // element itself + permutation of other elements make up all permutations
            let otherElemets = self.enumerated().filter{ $0.offset != tuple.offset}.map{$0.element}
            let permutationOthers = otherElemets.getPermutations()   // Get permuation of other elements
            for permutation in permutationOthers {
                permuations.append( [tuple.element] + permutation )
            }
        }
        return permuations
    }
    /// Test if contains subarray
    func containsSubarray(subArray:[Element])->Bool{
        guard subArray.count <= self.count else { return false }
        for i in 0...self.count-subArray.count{
            let slice = Array(self[i..<i+subArray.count])
            if slice == subArray { return true }
        }
        return false
    }
}
extension Array  {  // let array contains to deal with tuple
    func contains<E1, E2>(_ tuple: (E1, E2)) -> Bool where E1: Equatable, E2: Equatable, Element == (E1, E2) {
        return contains { $0.0 == tuple.0 && $0.1 == tuple.1 }
    }
}
