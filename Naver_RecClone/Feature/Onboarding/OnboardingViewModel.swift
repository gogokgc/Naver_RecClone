//
//  OnboardingViewModel.swift
//  voiceMemo
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var onboadingContents: [OnboardingContent]
    
    init(
        onboadingContents: [OnboardingContent] = [
            .init(imageFileNmae: "onboarding_1",
                  title: "오늘의 할일",
                  subTitle: "Todo List"
                 ),
            .init(imageFileNmae: "onboarding_2",
                  title: "기록장",
                  subTitle: "메모장"
                 ),
            .init(imageFileNmae: "onboarding_3",
                  title: "음성",
                  subTitle: "음성메모"
                 ),
            .init(imageFileNmae: "onboarding_4",
                  title: "시간",
                  subTitle: "타이머"
                 )
        ]) {
        self.onboadingContents = onboadingContents
    }
}
