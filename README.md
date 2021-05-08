# EveryLog

A description of this package.

## Add Log

Create a log file with a custom string
```swift
try? EveryLog.stande.addLog("test log")
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
