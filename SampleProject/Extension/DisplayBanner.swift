//
//  DisplayBanner.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import BRYXBanner
class DisplayBanner1 {
    class  func show(title:String?, subtitle: String? = nil, duration: Double = 3.2) {
        guard let title = title, !title.isEmpty else {
            return
        }
        //let banner = Banner(title: message, subtitle: "", image: nil, backgroundColor: UIColor(red:0.00/255.0, green:124.00/255.0, blue:198.00/255.0, alpha:1.000))
        let banner = Banner(title: title.localized() , subtitle: subtitle, image: nil, backgroundColor: Color.appLightErrorRed)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
        Console.log("DisplayBanner :- \(title)")
    }
}

class DisplayBanner2 {
    class  func show(title:String?, subtitle: String? = nil, duration: Double = 3.2) {
        guard let title = title, !title.isEmpty else {
            return
        }
        //let banner = Banner(title: message, subtitle: "", image: nil, backgroundColor: UIColor(red:0.00/255.0, green:124.00/255.0, blue:198.00/255.0, alpha:1.000))
        let banner = Banner(title: title.localized() , subtitle: subtitle, image: nil, backgroundColor: Color.appLightSuccessGreen)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
        Console.log("DisplayBanner :- \(title)")
    }
}


class DisplayBanners {
    class  func show(message:String?, duration: TimeInterval = 3){
        if let message = message, !message.isEmpty {
            let banner = Banner(title: message, subtitle: "", image: nil,backgroundColor: Color.appLightErrorRed)
            banner.dismissesOnTap = true
            banner.show(duration: duration)
        }
    }
}

