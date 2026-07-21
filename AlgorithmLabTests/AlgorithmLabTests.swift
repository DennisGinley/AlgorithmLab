//
//  AlgorithmLabTests.swift
//  AlgorithmLabTests
//
//  Created by Dennis Ginley on 7/17/26.
//

import Testing
@testable import AlgorithmLab

import Testing
@testable import AlgorithmLab

struct AlgorithmLabTests {

    @Test
    func emptyArraySortsCorrectly() {
        var values: [Int] = []

        let maxDepth = SortingAlgorithms.quickSort(&values)

        #expect(values.isEmpty)
        #expect(maxDepth == 0)
    }

    @Test
    func singleElementSortsCorrectly() {
        var values = [42]

        let maxDepth = SortingAlgorithms.quickSort(&values)

        #expect(values == [42])
        #expect(maxDepth == 1)
    }

    @Test
    func twoElementsSortCorrectly() {
        var values = [2, 1]

        _ = SortingAlgorithms.quickSort(&values)

        #expect(values == [1, 2])
    }

    @Test
    func sortedArrayRemainsSorted() {
        var values = [1, 2, 3, 4, 5]

        _ = SortingAlgorithms.quickSort(&values)

        #expect(values == [1, 2, 3, 4, 5])
    }

    @Test
    func duplicateValuesSortCorrectly() {
        expectSorted([3, 1, 3, 2, 1, 2, 3])
    }

    @Test
    func negativeValuesSortCorrectly() {
        expectSorted([0, -5, 8, -1, 3, -5])
    }

    @Test
    func reversedArraySortsCorrectly() {
        expectSorted([5, 4, 3, 2, 1])
    }

    @Test
    func generatedArrayMatchesSwiftSort() {
        var values = Array(0..<1_000).map { _ in
            Int.random(in: -10_000...10_000)
        }
        let expected = values.sorted()

        _ = SortingAlgorithms.quickSort(&values)

        #expect(values == expected)
    }
    
    @Test
    func allElementsEqual() {
        var values = Array(repeating: 7, count: 100)

        _ = SortingAlgorithms.quickSort(&values)

        #expect(values == Array(repeating: 7, count: 100))
    }
    
    @Test
    func largeRandomArrayMatchesSwiftSort() {
        var values = Array(0..<100_000).map { _ in
            Int.random(in: Int.min...Int.max)
        }
        let expected = values.sorted()

        _ = SortingAlgorithms.quickSort(&values)

        #expect(values == expected)
    }
    
    private func expectSorted(_ values: [Int]) {
        var actual = values
        let expected = values.sorted()

        _ = SortingAlgorithms.quickSort(&actual)

        #expect(actual == expected)
    }
}
