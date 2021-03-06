//
//  PartyExample.swift
//  swiftz
//
//  Created by Maxwell Swadling on 9/06/2014.
//  Copyright (c) 2014-2016 Maxwell Swadling. All rights reserved.
//

import XCTest
import Focus

// A party has a host, who is a user.
// A lens example
class Party {
	let host : User

	init(h : User) {
		host = h
	}

	class func lpartyHost() -> Lens<Party, Party, User, User> {
		let getter = { (party : Party) -> User in
			party.host
		}

		let setter = { (party : Party, host : User) -> Party in
			Party(h: host)
		}

		return Lens(get: getter, set: setter)
	}
}

class PartySpec : XCTestCase {
	func testLens() {
		let party = Party(h: User("max", 1, [], "one"))
		let hostnameLens = Party.lpartyHost() • User.luserName()

		XCTAssert(hostnameLens.get(party) == "max")

		let updatedParty: Party = (Party.lpartyHost() • User.luserName()).set(party, "Max")
		XCTAssert(hostnameLens.get(updatedParty) == "Max")
	}
}
