//
//  AWSManager.swift
//  CSDS395
//
//  Created by Nivita Patri on 9/10/23.
//

import Foundation
import SotoS3

let bucket = "quicode"

let client = AWSClient(
    credentialProvider: .static(accessKeyId: "Your-Access-Key", secretAccessKey: "Your-Secret-Key"),
    httpClientProvider: .createNew
)
let s3 = S3(client: client, region: .uswest2)
