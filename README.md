# EveryLog

A description of this package.

## Add Log

Create a log file with a **custom** string
```swift
try? EveryLog.stande.addLog("test log")
```

Add logs via **built-in format**
```swift
try? EveryLog.stande.addLog(type: .info, "Test Info Log")
```

Distinguish the **log level** by setting the type
```swift
case info
case warning
case danger
case unowned
```

## Get Log

```swift
let logs = EveryLog.stande.getLog()
```
You will get a data array containing log time, content, etc.

```swift
struct Log {
    let time:Date
    let type:Degree
    let content:String
}
```

## Use

Use **swift package** to add directly
