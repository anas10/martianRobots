//
//  Position.swift
//  martianRobotsLib
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

struct Position {
    let x: Int
    let y: Int
    let orientation: Orientation
}

extension Position {
    func addToX(value: Int) -> Position {
        return Position(x: x + value, y: y, orientation: orientation)
    }

    func addToY(value: Int) -> Position {
        return Position(x: x, y: y + value, orientation: orientation)
    }

    func changeOrientation(to newOrientation: Orientation) -> Position {
        return Position(x: x, y: y, orientation: newOrientation)
    }
}
