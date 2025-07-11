//
//  ContentView.swift
//  birthdaysapp
//
//  Created by Scholar on 7/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var friends: [Friend] = [
        Friend(name: "John", birthday: .now),
        Friend(name: "Samantha", birthday:Date(timeIntervalSince1970: 0)) ]
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    
    var body: some View {
        NavigationStack {
            List(friends, id: \.name) { friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("awesome bday app")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        //textFieldStyle adds a box around the text input section
                    }
                    Button("pls save me") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        modelContext.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    .padding()
                    .background(.bar)
                }
            }
        }
    }
}
    
    #Preview {
        ContentView()
            .modelContainer(for: Friend.self, inMemory: true)
    }

