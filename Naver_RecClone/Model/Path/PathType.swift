//
//  PathType.swift
//  voiceMemo
//

enum PathType:Hashable {
    case homeView
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
