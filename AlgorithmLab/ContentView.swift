//
//  ContentView.swift
//  AlgorithmLab
//
//  Created by Dennis Ginley on 7/17/26.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var results: [BenchmarkResult] = []
    @State private var isRunning = false

    private let algorithms = [
        SortingAlgorithm(
            name: "QuickSort — Middle Pivot",
            sort: SortingAlgorithms.quickSort
        ),

        SortingAlgorithm(
            name: "Swift sort()",
            sort: { array in
                array.sort()
                return 0
            }
        )
    ]

    private let dataSets = [
        DataSetGenerator(
            name: "Random",
            generate: TestData.random
        ),
        DataSetGenerator(
            name: "Nearly Sorted",
            generate: TestData.nearlySorted
        ),
        DataSetGenerator(
            name: "Reversed",
            generate: TestData.reversed
        ),
        DataSetGenerator(
            name: "Sorted",
            generate: TestData.sorted
        ),
        DataSetGenerator(
            name: "Duplicates",
            generate: TestData.duplicates
        )
    ]

    private let sizes = [
        5_000,
        10_000,
        20_000,
        40_000,
        100_000,
        250_000,
        500_000,
        1_000_000
    ]

    var body: some View {
        NavigationStack {
            VStack {
                if results.isEmpty {
                    ContentUnavailableView(
                        "No Benchmark Results",
                        systemImage: "speedometer",
                        description: Text(
                            "Run the benchmark to generate results."
                        )
                    )
                } else {
                    resultsTable
                }
            }
            .navigationTitle("Algorithm Lab")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                        Button {
                            copyResults()
                        } label: {
                            Label("Copy Results", systemImage: "doc.on.doc")
                        }
                        .disabled(results.isEmpty)

                        Button {
                            runBenchmarks()
                        } label: {
                            if isRunning {
                                ProgressView()
                            } else {
                                Label(
                                    "Run",
                                    systemImage: "play.fill"
                                )
                            }
                        }
                        .disabled(isRunning)
                    }
            }   // end toolbar
        }
    }

    private var resultsTable: some View {
        Table(results) {
            TableColumn("Algorithm") { result in
                Text(result.algorithmName)
            }

            TableColumn("Data") { result in
                Text(result.dataSetName)
            }

            TableColumn("Size") { result in
                Text(result.size.formatted())
            }

            TableColumn("Seconds") { result in
                Text(
                    result.elapsedSeconds,
                    format: .number.precision(
                        .fractionLength(6)
                    )
                )
                .monospacedDigit()
            }
            
            TableColumn("Recursion Depth") { result in
                Text(result.recursion.formatted())
                    .monospacedDigit()
            }

            TableColumn("Valid") { result in
                Image(
                    systemName: result.isCorrect
                        ? "checkmark.circle.fill"
                        : "xmark.circle.fill"
                )
                .accessibilityLabel(
                    result.isCorrect
                        ? "Correct"
                        : "Incorrect"
                )
            }
        }
    }

    private func runBenchmarks() {
        isRunning = true

        results = BenchmarkRunner.run(
            algorithms: algorithms,
            dataSets: dataSets,
            sizes: sizes
        )

        isRunning = false
    }
    
    private func copyResults() {
            let header = "Algorithm\tData\tSize\tSeconds\tRecursion Depth\tValid"

            let rows = results.map { result in
                [
                    result.algorithmName,
                    result.dataSetName,
                    result.size.formatted(),
                    result.elapsedSeconds.formatted(
                        .number.precision(.fractionLength(6))
                    ),
                    result.recursion.formatted(),
                    result.isCorrect ? "Yes" : "No"
                ]
                .joined(separator: "\t")
            }

            UIPasteboard.general.string =
                ([header] + rows).joined(separator: "\n")
        }
}

#Preview {
    ContentView()
}
