//
//  AWSManager.swift
//  CSDS395
//
//  Created by Nivita Patri on 9/10/23.
//

import Foundation
import SotoS3

struct AWSManager {

    // store S3-related values in struct
    
    var bucket: String = "quicode"
    
    var client: AWSClient = AWSClient(
        credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
        httpClientProvider: .createNew
    )

    
    func uploadToAWS(filename: String, body: Data) async {
        let s3 = S3(client: client, region: .useast2)
        let payload = AWSPayload.byteBuffer(ByteBufferAllocator().buffer(bytes: body))
        let uploadRequest = S3.PutObjectRequest(
           body: payload,
           bucket: bucket,
           key: filename
       )
       print("Upload Request Created")

       do {
           try await s3.putObject(uploadRequest)
           print("Object uploaded successfully!")
       } catch {
           print("Error uploading object: \(error)")
       }
        
        do {
//            try await client.shutdown()
            try await s3.client.syncShutdown()
        }
        catch {
            print("Error shutting down")
        }
    }
    

    
    
    // gets a given file from the DB and will return the body as a string
    func getFile(fileName: String) async -> String{
        print("Getting Module List")
        let s3 = S3(client: client, region: .useast2)
        print("Create S3")
        
        let input = S3.GetObjectRequest(
            bucket: bucket,
            key: fileName
        )
        
        // attempt to retrieve
        do {
            let response = try await s3.getObject(input)
            
            // if the body is not null
            if let objectData = response.body {
                // try to unwrap and get content
              
                let data = objectData.asString()
                    if let unwrappedValue = data {
                        print("\(unwrappedValue)")
                        return unwrappedValue
                    } else {
                        // optionalValue is nil
                        print("The optional is nil")
                    }
                
            } else {
                print("No object data received.")
            }
            
            // shutdown client
            do {
                try await s3.client.shutdown()
            }
            catch {
                print("Error shutting down")
            }
        } catch {
            // Handle any errors that occur
            print("Error retrieving object: \(error)")
        }
        
        /// if something goes wrong, returns empty string
        return ""
    }
    
}
