//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                
                // Layout
                VStack(alignment: .leading) {
                    Text("Layout").bold().font(.title3)
                    Picker("", selection: vs.binding(keyPath: \.layout, send: k)) {
                        ForEach(Yabai.State.Layout.allCases) {
                            Text($0.uiDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                }
                
                // Padding
                Divider()
                VStack(alignment: .leading) {
                    Text("Padding").bold().font(.title3)
                    HStack {
                        StepperView("Top",    vs.binding(keyPath: \.paddingTop,    send: k))
                        StepperView("Bottom", vs.binding(keyPath: \.paddingBottom, send: k))
                        StepperView("Left",   vs.binding(keyPath: \.paddingLeft,   send: k))
                        StepperView("Right",  vs.binding(keyPath: \.paddingRight,  send: k))
                        StepperView("Gaps",   vs.binding(keyPath: \.windowGap,     send: k))
                    }
                }
                .disabled(vs.layout == .float)
                .opacity(vs.layout == .float ? 0.5 : 1.0)
                
                
                // Float-On-Top
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(keyPath: \.windowTopmost, send: k))
                                .labelsHidden()
                            
                            Text("Float-On-Top").bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled || vs.layout == .float)
                        .opacity(vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)

                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                        .disabled(vs.sipEnabled || vs.layout == .float)
                        .opacity(vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)
                }
                Spacer()
            }
            
            .padding()
            .navigationTitle("Space")
        }
    }
}



// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


