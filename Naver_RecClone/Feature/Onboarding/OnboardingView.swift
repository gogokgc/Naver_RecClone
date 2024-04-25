//
//  OnboardingView.swift
//  voiceMemo
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var todoListViewModel = TodoListViewModel()
    @StateObject private var memoListViewModel = MemoListViewModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(
                    for: PathType.self,
                    destination: {pathType in
                        switch pathType {
                        case .homeView:
                            HomeView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(todoListViewModel)
                                .environmentObject(memoListViewModel)
                            
                        case .todoView:
                            TodoView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(todoListViewModel)
                            
                        case let .memoView(isCreateMode, memo):
                            MemoView(
                                memoViewModel: isCreateMode ? .init(memo: .init(title: "", content: "", date: .now))
                                : .init(memo: memo ?? .init(title: "", content: "", date: .now)),
                                isCreateMode: isCreateMode
                            )
                            .navigationBarBackButtonHidden()
                            .environmentObject(memoListViewModel)
                        }
                    }
                )
        }
        .environmentObject(pathModel)
    }
}
// MARK: - 온보딩 컨텐츠 뷰
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            // 온보딩 셀리스트 뷰
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            //시작버튼 뷰
            StartBtnView()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - 온보딩 셀리스트 뷰
private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex = 0
    
    fileprivate init(
        onboardingViewModel: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            //온보딩 셀
            ForEach(Array(onboardingViewModel.onboadingContents.enumerated()), id: \.element) { index, OnboardingContent in
                OnboardingCellView(onboardingContenet: OnboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(
            selectedIndex % 2 == 0
            ? Color.customSky
            : Color.customBackgroundGreen
        )
        .clipped()
    }
}

// MARK: - 온보딩 셀 뷰
private struct OnboardingCellView: View {
    private var onboardingContenet: OnboardingContent
    
    fileprivate init(onboardingContenet: OnboardingContent) {
        self.onboardingContenet = onboardingContenet
    }
    
    fileprivate var body: some View {
        VStack{
            Image(onboardingContenet.imageFileNmae)
                .resizable()
                .scaledToFit()
            
            HStack{
                Spacer()
                
                VStack{
                    Spacer()
                        .frame(height: 46)
                    
                    Text(onboardingContenet.title)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContenet.subTitle)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            .background(Color.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

// MARK: - 시작하기 버튼 뷰
private struct StartBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    var body: some View {
        Button(
            action: {pathModel.paths.append(.homeView)},
            label: {
                HStack{
                    Text("시작하기")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.customGreen)
                    
                    Image("startHome")
                        .renderingMode(.template)
                        .foregroundColor(.customGreen)
                }
            }
        )
        .padding(.bottom, 50)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
