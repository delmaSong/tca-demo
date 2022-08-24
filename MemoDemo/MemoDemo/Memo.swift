//
//  Memo.swift
//  MemoDemo
//
//  Created by delma on 2022/08/18.
//

import ComposableArchitecture

// MARK: - Memo

struct MemoState: Hashable, Identifiable {
    var id = UUID()
    var contents = ""
    var isLiked = false
}

enum MemoAction {
    case like
    case save(contents: String)
}

struct MemoEnvironment {}

let memoReducer = Reducer<MemoState, MemoAction, MemoEnvironment> { state, action, _ in
    switch action {
    case .like:
        state.isLiked.toggle()
        return .none
        
    case .save(let contents):
        state.contents = contents
        return .none
    }
}

// MARK: - MemoList

struct MemoListState: Equatable {
    var memos: IdentifiedArrayOf<MemoState> = []
}

enum MemoListAction {
    case memo(id: UUID, action: MemoAction)
    case add
}

struct MemoListEnvironment {}

let memoListReducer = Reducer<MemoListState, MemoListAction, MemoListEnvironment>.combine(
    memoReducer.forEach(
        state: \MemoListState.memos,
        action: /MemoListAction.memo(id:action:),
        environment: { _ in MemoEnvironment() }
    ),
    
    Reducer { state, action, _ in
        switch action {
        case .memo(let id, let action):
            return .none
            
        case .add:
            state.memos.insert(MemoState(), at: 0)
            return .none
        }
    }
)

// MARK: - Viewer

struct ViewerState: Equatable {
    var status: ViewerStatus = .normal
    var memo: MemoState?

    enum ViewerStatus {
        case edit, normal
    }
}
//
//enum ViewerAction {
//    case editButtonTapped
//    case saveButtonTapped(contents: String)
//    case memo(id: MemoState.ID)
//}
//
//struct ViewerEnvironment {}
//
//let viewerReducer = Reducer<ViewerState, ViewerAction, ViewerEnvironment> { state, action, _ in
//    switch action {
//    case .editButtonTapped:
//        state.status = .edit
//        return .none
//
//    case .saveButtonTapped(let contents):
//        state.status = .normal
//        return .none
//
//    case .memo(let id):
//        return .none
//    }
//}
