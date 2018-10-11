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

struct SesameProperties {
    static let file: SesameProperties = {
        guard let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
            let apiKeys = NSDictionary(contentsOfFile: path) as? [String: Any],
            let sesameKeys = apiKeys["Sesame"] as? [String: String],
            let sesameProperties = SesameProperties(dict: sesameKeys)
            else { fatalError() }
        return sesameProperties
    }()

    let appId: String
    let auth: String
    let versionId: String
    let userId: String

    init?(dict: [String: Any]) {
        guard let appId = dict["appId"] as? String, !appId.isEmpty,
            let auth = dict["auth"] as? String, !auth.isEmpty,
            let versionId = dict["versionId"] as? String, !versionId.isEmpty,
            let userId = dict["userId"] as? String, !userId.isEmpty
            else { return nil }
        self.appId = appId
        self.auth = auth
        self.versionId = versionId
        self.userId = userId
    }
}
