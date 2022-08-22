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
    case likeButtonTapped(id: UUID)
}

struct MemoEnvironment {}

let memoReducer = Reducer<MemoState, MemoAction, MemoEnvironment> { state, action, _ in
    switch action {
    case .likeButtonTapped(let id):
        state.isLiked.toggle()
        return .none
    }
}

// MARK: - MemoList

struct MemoListState: Equatable {
    var memos: IdentifiedArrayOf<MemoState> = []
}

enum MemoListAction {
    case addButtonTapped
}

struct MemoListEnvironment {}

let memoListReducer = Reducer<MemoListState, MemoListAction, MemoListEnvironment> { state, action, _ in
    switch action {
    case .addButtonTapped:
        return .none
    }
}

// MARK: - Viewer

struct ViewerState: Equatable {
    var status: ViewerStatus = .normal
    var memo: MemoState?
    
    enum ViewerStatus {
        case edit, normal
    }
}

enum ViewerAction {
    case editButtonTapped
    case saveButtonTapped(contents: String)
    case memo(id: MemoState.ID)
}

struct ViewerEnvironment {}

let viewerReducer = Reducer<ViewerState, ViewerAction, ViewerEnvironment> { state, action, _ in
    switch action {
    case .editButtonTapped:
        state.status = .edit
        return .none
        
    case .saveButtonTapped(let contents):
        state.status = .normal
        return .none
        
    case .memo(let id):
        return .none
    }
}
