//
//  SortingAlgorithms.swift
//  AlgorithmLab
//
//  Created by Dennis Ginley on 7/17/26.
//

import Foundation

enum SortingAlgorithms {
    nonisolated static func quickSort(_ array: inout [Int]) -> Int {
        guard array.count > 1 else {
            return array.isEmpty ? 0 : 1
        }

        var currentDepth = 0
        var maxDepth = 0

        quickSort(
            &array,
            low: array.startIndex,
            high: array.index(before: array.endIndex),
            currentDepth: &currentDepth,
            maxDepth: &maxDepth
        )

        return maxDepth
    }

    nonisolated private static func quickSort(
        _ array: inout [Int],
        low: Int,
        high: Int,
        currentDepth: inout Int,
        maxDepth: inout Int
    ) {
        guard low < high else {
            return
        }

        currentDepth += 1
        maxDepth = max(maxDepth, currentDepth)
        defer { currentDepth -= 1 }

        let partitionIndex = partition(
            &array,
            low: low,
            high: high
        )

        quickSort(
            &array,
            low: low,
            high: partitionIndex,
            currentDepth: &currentDepth,
            maxDepth: &maxDepth
        )

        quickSort(
            &array,
            low: partitionIndex + 1,
            high: high,
            currentDepth: &currentDepth,
            maxDepth: &maxDepth
        )
    }

    nonisolated private static func partition(
        _ array: inout [Int],
        low: Int,
        high: Int
    ) -> Int {
        let pivot = array[low + (high - low) / 2]

        var left = low - 1
        var right = high + 1

        while true {
            repeat {
                left += 1
            } while array[left] < pivot

            repeat {
                right -= 1
            } while array[right] > pivot

            if left >= right {
                return right
            }

            array.swapAt(left, right)
        }
    }
}
