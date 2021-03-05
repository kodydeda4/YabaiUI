//
//  ExternalBarSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct ExternalBarSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let keyPath = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            SectionView("External Bar") {
                VStack(alignment: .leading) {
                    Text("External Bar")
                    Picker("External Bar", selection: viewStore.binding(keyPath: \.externalBar, send: keyPath)) {
                        ForEach(Yabai.State.ExternalBar.allCases) {
                            Text($0.rawValue)
                        }
                    }.labelsHidden()
                }
                
                Section(header: Text("Padding").bold()) {
                    HStack {
                        Stepper("Top \(viewStore.paddingTop)", value: viewStore.binding(keyPath: \.topPaddingExternalBar, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Stepper("Bottom \(viewStore.paddingTop)", value: viewStore.binding(keyPath: \.bottomPaddingExternalBar, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }.disabled(viewStore.externalBar == .off)
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct ExternalBarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalBarSettingsView(store: Yabai.defaultStore)
    }
}
