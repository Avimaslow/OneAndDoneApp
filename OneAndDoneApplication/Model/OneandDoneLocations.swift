//
//  OneandDoneLocations.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//


import CloudKit
import UIKit
struct OneandDoneLocations: Identifiable, Hashable {
    
    
    static let kname = "name"
    static let kDescription = "description"
    static let kSquareAsset = "squareAsset"
    static let kBannerAsset = "bannerAsset"
    static let kAddress     = "address"
    static let kLocation    = "location"
    static let kWebsiteURL  = "websiteURL"
    static let kPhoneNum    = "phoneNum"
    
    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNum: String

    init(record: CKRecord){
        id  = record.recordID
        name        = record["name"] as? String ?? "N/A"
        description = record[OneandDoneLocations.kDescription] as? String ?? "N/A"
        squareAsset = record[OneandDoneLocations.kSquareAsset] as? CKAsset
        bannerAsset = record[OneandDoneLocations.kBannerAsset] as? CKAsset
        address     = record[OneandDoneLocations.kAddress] as? String ?? "N/A"
        location    = record[OneandDoneLocations.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL  = record[OneandDoneLocations.kWebsiteURL] as? String ?? "N/A"
        phoneNum    = record[OneandDoneLocations.kPhoneNum] as? String ?? "N/A"
    }
    var SquareImage: UIImage {
        guard let squareAsset else { return placeholderImage.square}
            return squareAsset.convert2UIImage(in: .square)
        }
    
    
    var bannerImage: UIImage {
        guard let bannerAsset else { return placeholderImage.square}
            return bannerAsset.convert2UIImage(in: .banner)
        }
}

// no memberwise bc im creating my own initializer that takes in ckrecord. When making query i get ckrecords back
