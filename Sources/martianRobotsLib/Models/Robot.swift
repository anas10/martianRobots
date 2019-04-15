//
//  Robot.swift
//  martianRobotsLib
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

class Robot {
    var position: Position
    let instructions: [String]
    var lost: Bool

    init(position: Position, instructions: [String], lost: Bool = false) {
        self.position = position
        self.instructions = instructions
        self.lost = lost
    }
}

extension Robot {
    func moveForward() -> Position {
        switch self.position.orientation {
        case .north:
            return self.position.addToY(value: 1)
        case .south:
            return self.position.addToY(value: -1)
        case .east:
            return self.position.addToX(value: 1)
        case .west:
            return self.position.addToX(value: -1)
        }
    }

    func turnLeft() -> Position {
        switch self.position.orientation {
        case .north:
            return self.position.changeOrientation(to: .west)
        case .south:
            return self.position.changeOrientation(to: .east)
        case .east:
            return self.position.changeOrientation(to: .north)
        case .west:
            return self.position.changeOrientation(to: .south)
        }
    }

    func turnRight() -> Position {
        switch self.position.orientation {
        case .north:
            return self.position.changeOrientation(to: .east)
        case .south:
            return self.position.changeOrientation(to: .west)
        case .east:
            return self.position.changeOrientation(to: .south)
        case .west:
            return self.position.changeOrientation(to: .north)
        }
    }
}
