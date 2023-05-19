//
//  ContentView.swift
//  LocalNotification
//
//  Created by sofiadinizms on 19/05/23.
//

import SwiftUI
//import UserNotification
import UserNotifications

//Firstly, only alter the ContentView structure to add the buttons and their titles, but leave the Action brackets empyt


struct ContentView: View {
    var body: some View {
        VStack {
            //To send notifications to the user, we need to ask for permission first. We'll do this usign the first button
            
            Button("Request permission"){
                
                ///Notifications can take a variety of forms, but the most common thing to do is ask for permission to show alerts, badges, and sounds – that doesn’t mean we need to use all of them at the same time, but asking permission up front means we can be selective later on.
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){
                    success, error in
                    if success{
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            ///Now, we need to actually register the notification we'll send, and this will happen with the second button
            /// If the user grants permission, then we’re all clear to start scheduling notifications. Even though notifications might seem simple, Apple breaks them down into three parts to give it maximum flexibility:
            ///1. The content is what should be shown, and can be a title, subtitle, sound, image, and so on.
            ///2. The trigger determines when the notification should be shown, and can be a number of seconds from now, a date and time in the future, or a location.
            ///3. The request combines the content and trigger, but also adds a unique identifier so you can edit or remove specific alerts later on. If you don’t want to edit or remove stuff, use UUID().uuidString to get a random identifier.
            ///When you’re just learning notifications the easiest trigger type to use is UNTimeIntervalNotificationTrigger, which lets us request a notification to be shown in a certain number of seconds from now.
    
            Button("Schedule notifications"){
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
        .padding()
    }
}

///If you run your app now, press the first button to request notification permission, then press the second to add an actual notification.
///Now for the important part: once your notification has been added press Cmd+L in the simulator to lock the screen. After a few seconds
///have passed the device should wake up with a sound, and show our message – nice!

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//source: https://www.hackingwithswift.com/books/ios-swiftui/scheduling-local-notifications
