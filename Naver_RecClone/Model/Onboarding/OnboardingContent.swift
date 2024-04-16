//
//  OnboardingContent.swift
//  voiceMemo
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileNmae: String
    var title: String
    var subTitle: String
    
    init(
        imageFileNmae: String,
        title: String,
        subTitle: String
    ) {
        self.imageFileNmae = imageFileNmae
        self.title = title
        self.subTitle = subTitle
    }
}
