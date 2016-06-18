//
//  dbTools.swift
//  ZewoSrv
//
//  Created by Gorbenko Vladimir on 18/06/16.
//
//

import struct HTTPServer.Server
import Router

try migrateAll()

let app: Responder = Router { route in

    route.get("/hello") { request in
        return Response(body: "Hello, world!\n")
    }
}

let server = try Server(app)

try server.start()
