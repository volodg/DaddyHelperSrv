//
//  dbTools.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 18/06/16.
//
//

import struct HTTPServer.Server
import Router
import Foundation

try migrateAll()

struct IosLog {

    let text           : String?
    let events         : String?
    let userId         : String?
    let date           : NSDate
    let osVersion      : String?
    let appVersion     : String?
    let idfa           : String?
    let context        : String?
    let bundle         : String?
    let apiKey         : String?
    let apiVersion     : String?
    let appBuildVersion: String?
    let level          : String?
    let modelName      : String?
    let schema         : String?//live dev beta
}

#if os(Linux)
    typealias DateFormatter = NSDateFormatter

    extension DateFormatter {
        func date(from string: String) -> Date? {
            return dateFromString(string)
        }
    }
#endif

extension IosLog {

    static func fromJson(json: C7.StructuredData) throws -> IosLog {

        let dateStr: String? = json.get(optional: "Events")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let date = dateStr.flatMap { dateFormatter.date(from: $0) } ?? NSDate()

        let result = IosLog(
            text           : json.get(optional: "Text"  ),
            events         : json.get(optional: "Events"),
            userId         : json.get(optional: "UserId"),
            date           : date,
            osVersion      : nil,
            appVersion     : nil,
            idfa           : nil,
            context        : nil,
            bundle         : nil,
            apiKey         : nil,
            apiVersion     : nil,
            appBuildVersion: nil,
            level          : nil,
            modelName      : nil,
            schema         : nil)

        return result
    }
}

let app = Router { route in

    route.post("/push_ios_log") { request in

        let body = request.body

        switch body {
        case .buffer(let data):

            do {
                let jsonAr = try data.structuredData.asArray()

                for json in jsonAr {
                    
                }

                return Response(body: "Hello, world!\n")
            } catch let error {
                return Response(status: .notImplemented, headers: [:], body: "invalid json type: \(error)")
            }
        case .receiver:
            return Response(status: .notImplemented, headers: [:], body: "unsupported receiver stream body")
        case .sender:
            return Response(status: .notImplemented, headers: [:], body: "unsupported sender body")
        case .asyncReceiver://(AsyncStream)
            return Response(status: .notImplemented, headers: [:], body: "unsupported asyncReceiver body")
        case .asyncSender:
            return Response(status: .notImplemented, headers: [:], body: "unsupported asyncSender body")
        }
    }
}

let server = try Server(app)

try server.start()
