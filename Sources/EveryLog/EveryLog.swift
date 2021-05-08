import Foundation

enum Degree: String {
    case info = "info"
    case warning = "warning"
    case danger = "danger"
    case unowned = "unowned"
    
    static func string2Degree(_ string: String) -> Degree {
        switch string {
        case "info": return .info
        case "warning": return .warning
        case "danger": return .danger
        default: return .unowned
        }
    }
}

struct Log {
    let time:Date
    let type:Degree
    let content:String
}

class EveryLog {
    static let stande = EveryLog()
    
    let url:URL
    let fileManager = FileManager()
    
    init() {
        url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func addLog(date: Date = Date(), _ log: String) throws {
        let logUrl = url.appendingPathComponent("every.log")
        let time = date
        let timeString = date2String(time)
        do {
            var isFirst = false
            if !fileManager.fileExists(atPath: logUrl.path) {
                fileManager.createFile(atPath: logUrl.path, contents: nil, attributes: nil)
                isFirst = true
            }
            let file = try String(contentsOfFile: logUrl.path)
            if isFirst {
                let newFile = "\(timeString)|" + log
                try newFile.write(toFile: logUrl.path, atomically: true, encoding: .utf8)
            } else {
                let newFile = file + "\n" + "\(timeString)|" + log
                try newFile.write(toFile: logUrl.path, atomically: true, encoding: .utf8)
            }
        } catch {
            throw error
        }
    }
    
    func addLog(date: Date = Date(), type: Degree, _ log: String) throws {
        let logUrl = url.appendingPathComponent("every.log")
        let time = date
        let timeString = date2String(time)
        do {
            var isFirst = false
            if !fileManager.fileExists(atPath: logUrl.path) {
                fileManager.createFile(atPath: logUrl.path, contents: nil, attributes: nil)
                isFirst = true
            }
            let file = try String(contentsOfFile: logUrl.path)
            if isFirst {
                let newFile = "\(timeString) | \(type.rawValue) | " + log
                try newFile.write(toFile: logUrl.path, atomically: true, encoding: .utf8)
            } else {
                let newFile = file + "\n" + "\(timeString) | \(type.rawValue) | " + log
                try newFile.write(toFile: logUrl.path, atomically: true, encoding: .utf8)
            }
        } catch {
            throw error
        }
    }
    
    func getLog(_ file: String = "every.log") -> [Log] {
        let logUrl = url.appendingPathComponent(file)
        var logs = [Log]()
        guard let reader = LineReader(path: logUrl.path) else {
            return logs
        }

        for line in reader {
            let _content = line.split(separator: "|")
            if _content.count == 3 {
                print(String(_content[1]))
                let log = Log(time: string2Date(String(_content[0]).trim()), type: Degree.string2Degree(String(_content[1]).trim()), content: String(_content[2]).trim())
                logs.append(log)
            } else {
                let log = Log(time: string2Date(String(_content[0]).trim()), type: .unowned, content: String(_content[1]).trim())
                logs.append(log)
            }
        }
        return logs
    }
    
    func testLog(date: Date ,_ log: String) throws -> String {
        let timeString = date2String(date)
        let newFile = "\(timeString) | " + log
        return newFile
    }
    
    func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}

public class LineReader {
   public let path: String

   fileprivate let file: UnsafeMutablePointer<FILE>!

   init?(path: String) {
      self.path = path
      file = fopen(path, "r")
      guard file != nil else { return nil }
   }

   public var nextLine: String? {
      var line:UnsafeMutablePointer<CChar>? = nil
      var linecap:Int = 0
      defer { free(line) }
      return getline(&line, &linecap, file) > 0 ? String(cString: line!) : nil
   }

   deinit {
      fclose(file)
   }
}

extension LineReader: Sequence {
   public func  makeIterator() -> AnyIterator<String> {
      return AnyIterator<String> {
         return self.nextLine
      }
   }
}

extension String {
    
    func trim() -> String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }

}
