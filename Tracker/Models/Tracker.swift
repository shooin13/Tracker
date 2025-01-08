import Foundation

struct Tracker: Identifiable {
  let id: UUID
  let title: String
  let color: String
  let emoji: String
  let schedule: [Weekday]
}

enum Weekday: String, CaseIterable {
  case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}
