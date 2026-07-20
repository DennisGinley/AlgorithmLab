//
//  BenchmarkResult.swift
//  AlgorithmLab
//
//  Created by Dennis Ginley on 7/17/26.
//

import Foundation

struct BenchmarkResult: Identifiable {
    let id = UUID()

    let algorithmName: String
    let dataSetName: String
    let size: Int
    let elapsed: Duration
    let recursion: Int
    let isCorrect: Bool

    var elapsedSeconds: Double {
        let components = elapsed.components

        return Double(components.seconds)
            + Double(components.attoseconds) / 1_000_000_000_000_000_000
    }
}
