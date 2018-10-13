//
//  SesameTests.swift
//  Depressed?Tests
//
//  Created by Akash Desai on 10/10/18.
//  Copyright © 2018 Christian Lobach. All rights reserved.
//

import XCTest
@testable import Sesame

class SesameTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {

    }

    func testReinforcement() {
        class ReinforcementDelegate: SesameReinforcementDelegate {
            var promise: XCTestExpectation!
            func reinforce(sesame: Sesame, effectViewController: BMSEffectViewController) {
                promise.fulfill()
            }
        }
        let delegate = ReinforcementDelegate()
        delegate.promise = expectation(description: "Got reinforcement")
        let sesame = Sesame(
            appId: SesameProperties.file.appId,
            auth: SesameProperties.file.auth,
            versionId: SesameProperties.file.versionId,
            userId: SesameProperties.file.userId
        )
        sesame.reinforcementDelegate = delegate

        sesame.addEvent(actionName: BMSEvent.AppOpenName, reinforce: true)

        waitForExpectations(timeout: 3)
    }

}
