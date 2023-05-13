//
//  bmiCSVManager.swift
//  DrZot
//
//  Created by Chris Ruan on 5/3/23.
//

import Foundation

struct CSVRow {
    let columns: [String]
}

class CSVParser {
    let csvURL: URL

    init(csvURL: URL) {
        self.csvURL = csvURL
    }

    func parseCSV() -> [CSVRow]? {
        do {
            let csvData = try String(contentsOf: csvURL, encoding: .utf8)
            let rows = csvData.components(separatedBy: "\n")
            var parsedRows: [CSVRow] = []
            for row in rows {
                let columns = row.components(separatedBy: ",")
                let csvRow = CSVRow(columns: columns)
                parsedRows.append(csvRow)
            }
            return parsedRows
        } catch {
            print("Error parsing CSV: \(error)")
            return nil
        }
    }
}
