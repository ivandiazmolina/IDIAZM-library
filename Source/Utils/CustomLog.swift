//
//  CustomLog.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 07/09/2020.
//

public class CustomLog {
    
    public enum LogCategory: String {
        case `default`
        case repository
    }
    
    public enum LogType: String {
        case `default`
        case info
        case debug
        case error
        case success
    }
    
    /// Print log by console
    /// - Parameter type: type of log
    /// - Parameter category: category of log
    /// - Parameter filePath: absolute path of the file where the log has been executed
    /// - Parameter functionName: name of the function where the log has been executed
    /// - Parameter lineNumber: line number where the log has been executed
    /// - Parameter items: object to print in to console
    public static func log(type: LogType, category: LogCategory, filePath: String = #file, functionName: String = #function, lineNumber: Int = #line, item: Any) {
        #if DEBUG
        print("\(getTime()) [CustomLog-\(category.rawValue)] \(getType(type: type)): \(getFileName(filePath)) - \(functionName) at line \(lineNumber), Data: --> \(dump(item))")
        #endif
    }
    
    /// Get the log type
    /// - Parameter type: tipo de log
    private static func getType(type: LogType) -> String {
        switch type {
        case .info:
            return "🟡 INFO"
        case .debug:
            return "🔵 DEBUG"
        case .error:
            return "🔴 ERROR"
        case .success:
            return "🟢 SUCCESS"
        default:
            return "⚪️ DEFAULT"
        }
    }
    
    /// Get current time
    private static func getTime() -> String {
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    /// Get file name from file path
    /// - Parameter filePath: ruta del fichero
    private static func getFileName(_ filePath: String ) -> String {
        return (filePath as NSString).lastPathComponent
    }
}
