import Foundation

struct CatchRecord: Identifiable, Codable {
    let id: UUID
    let fishId: UUID
    let date: Date
    let location: String
    let weight: Double
    let length: Double
    let photoData: Data?
    let notes: String
    let weather: Weather

    init(
        id: UUID = UUID(),
        fishId: UUID,
        date: Date = Date(),
        location: String,
        weight: Double,
        length: Double,
        photoData: Data? = nil,
        notes: String = "",
        weather: Weather
    ) {
        self.id = id
        self.fishId = fishId
        self.date = date
        self.location = location
        self.weight = weight
        self.length = length
        self.photoData = photoData
        self.notes = notes
        self.weather = weather
    }

    var formattedWeight: String {
        if weight >= 1 {
            return String(format: "%.2f kg", weight)
        } else {
            return String(format: "%.0f g", weight * 1000)
        }
    }

    var formattedLength: String {
        String(format: "%.1f cm", length)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
