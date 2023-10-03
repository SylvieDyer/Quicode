//
//  AWSManager.swift
//  CSDS395
//
//  Created by Nivita Patri on 9/10/23.
//

import Foundation
import SotoS3

struct AWSManager {
    func main() async -> Data {
        
        let bucket = "quicode"
        
        let client = AWSClient(
            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
            httpClientProvider: .createNew
        )
        print("Made Client")
        let s3 = S3(client: client, region: .useast2)
        print("Create S3")
        
        
        
        
        /// FOR UPLOADING
//        let uploadRequest = S3.PutObjectRequest(
//            bucket: "quicode",
//            key: "example2.png"
//        )
//        print("Upload Request Created")
//
//        do {
//            try s3.putObject(uploadRequest).wait()
//            print("Object uploaded successfully!")
//        } catch {
//            print("Error uploading object: \(error)")
//        }
//
        let input = S3.GetObjectRequest(
            bucket: "quicode",
            key: "fun.json"
        )
        
        /// FOR FETCHING
        
//        do {
//            let response = try await s3.getObject(input)
//
//            if let objectData = response.body {
//                do {
//                    let data = try? objectData.asString()
//                    if let unwrappedValue = data {
//                        print("\(unwrappedValue)")
//                    } else {
//                        // optionalValue is nil
//                        print("The optional is nil")
//                    }
//                } catch {
//                    print("Error converting object data to Data: \(error)")
//                }
//            } else {
//                print("No object data received.")
//            }
//            
//            do {
//                try await s3.client.shutdown()
//            }
//            catch {
//                print("Error shutting down")
//            }
//        } catch {
//            // Handle any errors that occur
//            print("Error downloading object: \(error)")
//        }

        
      
//        do {
//            let output = try await s3.getObject(input)
//            guard let body = output.body,
//                  let data = try await body.asData()
//            else {
//                return "".data(using: .utf8)!
//            }
//
//            do {
//                try await s3.client.shutdown()
//            }
//            catch {
//                print("Error shutting down")
//            }
//
//            return data
//        }
//        catch {
//            print("error getting")
//        }
    
        return Data()
        
    }
}
