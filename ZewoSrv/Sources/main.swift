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
import JSON

try migrateAll()

extension IosLog {

    static func fromJson(json: StructuredData) -> IosLog {

        let dateStr: String? = json.get(optional: "Date")

        let dateFormatter = DateFormatter.dbDateFormat()
        let date = dateStr.flatMap { dateFormatter.date(from: $0) } ?? Date()

        let result = IosLog(
            text           : json.get(optional: "Text"  ),
            events         : json.get(optional: "Events"),
            userId         : json.get(optional: "UserId"),
            date           : date,
            osVersion      : json.get(optional: "OS Version"),
            appVersion     : json.get(optional: "AppVersion"),
            idfa           : json.get(optional: "IDFA"),
            context        : json.get(optional: "Context"),
            bundle         : json.get(optional: "Bundle"),
            apiKey         : json.get(optional: "ApiKey"),
            apiVersion     : json.get(optional: "API Version"),
            appBuildVersion: json.get(optional: "AppBuildVersion"),
            level          : json.get(optional: "Level"),
            modelName      : json.get(optional: "Model Name"),
            schema         : json.get(optional: "Schema")
        )

        return result
    }
}

let app = Router { route in

    route.post("/push_ios_log") { request in

        let body = request.body

        switch body {
        case .buffer(let data):

            do {
                let str = try String(data: data)
                print("str: \(str)")
                let dataAr = str.structuredData
                print("dataAr: \(dataAr)")
                let jsonAr = try dataAr.asArray()

                do {
                    let connection = try getOpenConnection()

                    for json in jsonAr {

                        let log = IosLog.fromJson(json: json)

                        try log.putToDb(connection: connection)
                    }

                    return Response(body: "Hello, world!\n")
                } catch let error {
                    return Response(status: .notImplemented, headers: [:], body: "db error")
                }
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
