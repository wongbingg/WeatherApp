//
//  Console.swift
//  WeatherApp
//
//  Created by 이원빈 on 7/23/24.
//

public struct Console {
    public static func log(_ message: String) {
        print("[LOG] \(message)")
    }
    
    public static func debug(_ message: String) {
        print("[DEBUG] \(message)")
    }
    
    public static func error(_ message: String) {
        print("[ERROR] \(message)")
    }
}
