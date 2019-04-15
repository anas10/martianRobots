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


    /**
     Process mars object and executes all robots instructions then prints results

     - parameters:
        - mars: a valid Mars object
     */
    public func process(mars: Mars) {

        mars.robots.forEach { robot in

            for instruction in robot.instructions {
                if let newPosition = robot.executeInstruction(instruction) {
                    if mars.isPositionOutsideWorld(position: newPosition) {
                        if !isProtected(scents: scents, position: newPosition) {
                            scents.append(newPosition)
                            robot.lost = true
                            break
                        }
                    } else {
                        robot.position = newPosition
                    }
                }
            }

            print(robot.status)
        }

    }

    /**
     Check if the position already exist in the array provided

     - parameters:
        - scents: an array of position to check against
        - position: a position to check

     - returns: A Boolean the position is found.
     */
    private func isProtected(scents: [Position], position: Position) -> Bool {
        return scents.contains(where: { $0.x == position.x && $0.y == position.y })
    }

}

