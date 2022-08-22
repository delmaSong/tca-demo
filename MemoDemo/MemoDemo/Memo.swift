//
//  Memo.swift
//  MemoDemo
//
//  Created by delma on 2022/08/18.
//

import ComposableArchitecture

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

struct EditorState: Equatable {
    var status: EditorStatus = .normal
    var memos: IdentifiedArrayOf<MemoState> = []
    
    enum EditorStatus {
        case edit, normal
    }
}

enum EditorAction {
    case editButtonTapped
    case saveButtonTapped
    case addButtonTapped
    case memo(id: MemoState.ID)
}

struct EditorEnvironment {}

let editorReducer = Reducer<EditorState, EditorAction, EditorEnvironment> { state, action, _ in
    switch action {
    case .editButtonTapped:
        state.status = .edit
        return .none
        
    case .saveButtonTapped:
        state.status = .normal
        return .none
        
    case .addButtonTapped:
        state.status = .edit
        // 저장 필요..
        return .none
        
    case .memo(let id):
        return .none
    }
}
