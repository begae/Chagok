//
//  Settings.swift
//  Chagok
//
//  Created by 김세령 on 10/12/24.
//

import SwiftUI
import UserNotifications

struct Settings: View {
    enum TimeRange: String, CaseIterable, Identifiable {
        case working, fixed
        var id: Self { self }
    }
    
    @AppStorage("selectedTimeRange") private var selectedTimeRange: TimeRange = .working
    @AppStorage("isNotificationsEnabled") private var isNotificationsEnabled = false
    @AppStorage("selectedTime") private var selectedTime = Date()
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("Notifications", isOn: $isNotificationsEnabled)
                if isNotificationsEnabled {
                    Picker("Sent at", selection: $selectedTimeRange) {
                        Text("Between 9 and 5").tag(TimeRange.working)
                        Text("Fixed time").tag(TimeRange.fixed)
                    }
                    if selectedTimeRange == .fixed {
                        DatePicker(
                            "Select time",
                            selection: $selectedTime,
                            displayedComponents: [.hourAndMinute]
                        )
                    }
                }
            }
            .onAppear() {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                    if success {
                        print("Permission approved!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .onChange(of: isNotificationsEnabled, initial: true) { enabled, _ in
                if enabled {
                    scheduleNotification()
                } else {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                }
            }
            .onChange(of: selectedTime, initial: true) { time, _ in
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                scheduleNotification()
            }
            .navigationTitle("Settings")
        }
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Saving Reminder"
        content.body = "Chagok, chagok."
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        
        if selectedTimeRange == .fixed {
            let calendar = Calendar.current
            dateComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        } else {
            // Random time between 9 AM and 5 PM
            let randomHour = Int.random(in: 9...16)
            let randomMinute = Int.random(in: 0...59)
            dateComponents.hour = randomHour
            dateComponents.minute = randomMinute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled at \(dateComponents.hour ?? 0):\(dateComponents.minute ?? 0)")
            }
        }
    }
}
