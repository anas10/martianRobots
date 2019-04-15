//
//  Utils.swift
//  martianRobotsApp
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

// MARK: - Error
enum ParsingError: Error {
    case robotIncomplete
    case robotInvalidData
    case areaIncomplete
    case coordinateInvalid
}

extension ParsingError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .robotInvalidData:
            return NSLocalizedString("[Robot] Invalid data", comment: "Parsing error - robot invalid data")
        case .robotIncomplete:
            return NSLocalizedString("[Robot] 2 lines per robot required", comment: "Parsing error - robot incomplete")
        case .areaIncomplete:
            return NSLocalizedString("[Area] Incomplete", comment: "Parsing error - area incomplete")
        case .coordinateInvalid:
            return NSLocalizedString("[Coordinate] Invalid", comment: "Parsing error - coordinate invalid")
        }
    }
}

// MARK: - Result
enum Result<Value> {
    case success(Value)
    case failure(LocalizedError)
}

extension Result {
    func onCompletion(verbose: Bool = true, _ success: (Value) -> ()) {
        switch self {
        case .success(let value):
            success(value)
        case .failure(let error):
            if verbose {
                printError(error.errorDescription ?? "unknown error")
            }
        }
    }

    func isSuccessful() -> Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
}

// MARK: - Helpers
func printError(_ value: String) {
    fputs("\(value)\n", stderr)
}
