//
//  Loader.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

class Loader {

    class func show(isInteractive: Bool = false) {
        SKActivityIndicator.spinnerStyle(.spinningCircle)
        SKActivityIndicator.spinnerColor(Color.applightBlue)
        SKActivityIndicator.show("", userInteractionStatus: isInteractive)
    }
    class func hide() {
        SKActivityIndicator.dismiss()
    }
 
}

