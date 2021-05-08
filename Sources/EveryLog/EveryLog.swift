import Foundation

class EveryLog {
    static let stande = EveryLog()
    
    let url:URL
    let fileManager = FileManager()
    
    init() {
        url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func addLog(_ log: String) throws {
        let logUrl = url.appendingPathComponent("every.log")
        let time = Date()
        let timeString = date2String(time)
        do {
            let file = try String(contentsOfFile: logUrl.path)
            let newFile = file + "\n" + "\(timeString) | " + log
            try newFile.write(toFile: logUrl.path, atomically: true, encoding: .utf8)
        } catch {
            throw error
        }
    }
    
    func getLog(_ file: String = "every.log") throws -> String {
        let logUrl = url.appendingPathComponent(file)
        do {
            let file = try String(contentsOfFile: logUrl.path)
            return file
        } catch {
            throw error
        }
    }
    
    func testLog(date: Date ,_ log: String) throws -> String {
        let timeString = date2String(date)
        let newFile = "\(timeString) | " + log
        return newFile
    }
    
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}
