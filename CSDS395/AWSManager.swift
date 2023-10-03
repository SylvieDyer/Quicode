//
//  AWSManager.swift
//  CSDS395
//
//  Created by Nivita Patri on 9/10/23.
//

import Foundation
import SotoS3

struct AWSManager {
    func main() {
        
        let bucket = "quicode"
        
        let client = AWSClient(
            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
            httpClientProvider: .createNew
        )
        let s3 = S3(client: client, region: .useast2)
        
        
        let uploadRequest = S3.PutObjectRequest(
            bucket: "quicode",
            key: "example.png"
        )
        
        do {
            try s3.putObject(uploadRequest).wait()
            print("Object uploaded successfully!")
        } catch {
            print("Error uploading object: \(error)")
        }
    }
}
