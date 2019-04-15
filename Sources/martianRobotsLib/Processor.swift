//
//  Processor.swift
//  martianRobotsLib
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

public class Processor {

    private var scents: [Position] = []

    // This is required to make this class usuable and testable outside the module
    public init() {}

    public func process(mars: Mars) {
        for robot in mars.robots {

            for instruction in robot.instructions {

                var newPosition: Position?
                switch instruction {
                case "R":
                    newPosition = robot.turnRight()
                case "L":
                    newPosition = robot.turnLeft()
                case "F":
                    newPosition = robot.moveForward()
                default: break
                }

                if let newPosition = newPosition {
                    if mars.isPositionOutsideWorld(position: newPosition) {
                        let protected = scents.contains(where: { $0.x == newPosition.x && $0.y == newPosition.y })
                        if !protected {
                            scents.append(newPosition)
                            robot.lost = true
                            break
                        }
                    } else {
                        robot.position = newPosition
                    }
                }
            }

            let finalPosition = robot.position

            print("\(finalPosition.x) \(finalPosition.y) \(finalPosition.orientation.rawValue)\(robot.lost ? " LOST" : "")")
        }
    }
}

