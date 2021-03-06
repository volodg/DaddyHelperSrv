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

    route.get("/hello") { request in

        return Response(body: "Hello, world! ver 10\n")
    }

    route.post("/push_ios_log") { request in

        let body = request.body

        switch body {
        case .buffer(let data):

            do {
                let parser = JSONStructuredDataParser()
                let json = try parser.parse(data)
                guard let jsonAr = json.arrayValue else {
                    return Response(status: .badRequest, headers: [:], body: "invalid json type: \(json)")
                }

                do {
                    let connection = try getOpenConnection()

                    for json in jsonAr {

                        let log = IosLog.fromJson(json: json)
                        try log.putToDb(connection: connection)
                    }

                    #if os(Linux)
                        return Response(body: "Hello, world from docker! ver 10\n")
                    #endif
                    return Response(body: "Hello, world! ver 10\n")
                } catch let error {
                    return Response(status: .internalServerError, headers: [:], body: "db error\n")
                }
            } catch let error {
                return Response(status: .badRequest, headers: [:], body: "invalid json type: \(error)")
            }
        case .receiver:
            return Response(status: .notImplemented, headers: [:], body: "unsupported receiver stream body")
        case .sender:
            return Response(status: .notImplemented, headers: [:], body: "unsupported sender body")
        case .asyncReceiver:
            return Response(status: .notImplemented, headers: [:], body: "unsupported asyncReceiver body")
        case .asyncSender:
            return Response(status: .notImplemented, headers: [:], body: "unsupported asyncSender body")
        }
    }
}

let server = try Server(app)
    //Server(host: "127.0.0.1", port: 80, responder: app)

try server.start()
