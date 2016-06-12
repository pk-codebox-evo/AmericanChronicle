//
//  FakeSearchView.swift
//  AmericanChronicle
//
//  Created by Ryan Peterson on 9/21/15.
//  Copyright © 2015 ryanipete. All rights reserved.
//

@testable import AmericanChronicle

class FakeSearchView: SearchViewInterface {

    weak var delegate: SearchViewDelegate?
    var searchTerm: String?
    var earliestDate: String?
    var latestDate: String?
    var USStates: String?

    var setViewState_wasCalled_withState: ViewState?
    func setViewState(state: ViewState) {
        setViewState_wasCalled_withState = state
    }

    func setBottomContentInset(bottom: CGFloat) {

    }

    func resignFirstResponder() -> Bool {
        return true
    }


}