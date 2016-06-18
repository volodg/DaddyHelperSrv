//
//  main.swift
//  PerfectSrv
//
//  Created by Gorbenko Vladimir on 17/06/16.
//	Copyright (C) 2016 Volodymyr. All rights reserved.
//

import PerfectLib

// Initialize base-level services
PerfectServer.initializeServices()

// Create our webroot
// This will serve all static content by default
let webRoot = "./webroot"
try Dir(webRoot).create()

try migrateAll()

// Add our routes and such
// Register your own routes and handlers
Routing.Routes["/"] = {
    request, response in

    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    response.requestCompleted()
}

Routing.Routes["/push_ios_log"] = {
    request, response in

    switch request.requestMethod {
    case .post:

        do {
            if let json = try request.postBodyString.jsonDecode() as? [Any] {

                response.appendBody(string: "ok: \(json)\n")
            } else {
                response.setStatus(code: 500, message: "Invalid json type: json")
            }
        } catch let error {
            response.setStatus(code: 500, message: "Unexpected Error: \(error)")
        }

        print("request: \(request.postBodyString)")
    default:
        response.setStatus(code: 500, message: "Invalid method")
    }

    //response.setStatus(code: 500, message: ":-(")

    //response.appendBody(string: "ok\n")
    response.requestCompleted()
}

do {

    // Launch the HTTP server on port 8181
    try HTTPServer(documentRoot: webRoot).start(port: 8181)

} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
