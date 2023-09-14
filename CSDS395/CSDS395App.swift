//
//  CSDS395App.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 9/1/23.
//

import SwiftUI

import Foundation
import SotoS3

@main
struct CSDS395App: App {

    var body: some Scene {
        WindowGroup {
         HomeView(controller: AppController())
//           LoginView()
        }
    }
//    static func main() {
//
//        let bucket = "quicode"
//
//        let client = AWSClient(
//            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
//            httpClientProvider: .createNew
//        )
//        let s3 = S3(client: client, region: .useast2)
//
//
//        let uploadRequest = S3.PutObjectRequest(
//            bucket: "quicode",
//            key: "example.png"
//        )
//
//        do {
//            try s3.putObject(uploadRequest).wait()
//            print("Object uploaded successfully!")
//        } catch {
//            print("Error uploading object: \(error)")
//        }
//
        
    //}
    
}

struct Previews_CSDS395App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
