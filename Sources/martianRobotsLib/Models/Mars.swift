//
//  Mars.swift
//  martianRobotsLib
//
//  Created by Anas Ait Ali on 15/04/2019.
//

import Foundation

struct Mars {
    var world: World
    var robots: [Robot]

    init() {
        self.world = World(top: 0, right: 0, bottom: 0, left: 0)
        self.robots = []
    }
}

extension Mars: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        {
        world: \(world),
        robots: \(robots)
        }
        """
    }
}
