//
//  TestData.swift
//  AlgorithmLab
//
//  Created by Dennis Ginley on 7/17/26.
//

import Foundation

enum TestData {
    nonisolated static func random(size: Int) -> [Int] {
        (0..<size).map { _ in
            Int.random(in: 0...size)
        }
    }

    nonisolated static func sorted(size: Int) -> [Int] {
        Array(0..<size)
    }

    nonisolated static func reversed(size: Int) -> [Int] {
        Array((0..<size).reversed())
    }

    nonisolated static func nearlySorted(size: Int) -> [Int] {
        var values = Array(0..<size)

        guard size > 1 else {
            return values
        }

        let swapCount = max(1, size / 100)

        for _ in 0..<swapCount {
            let first = Int.random(in: values.indices)
            let second = Int.random(in: values.indices)
            values.swapAt(first, second)
        }

        return values
    }

    nonisolated static func duplicates(size: Int) -> [Int] {
        (0..<size).map { _ in
            Int.random(in: 0...9)
        }
    }
}
