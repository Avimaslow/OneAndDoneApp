//
//  mockData.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import CloudKit
struct mockData{
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[OneandDoneLocations.kname]           = "Avi's Bar & Grill"
        record[OneandDoneLocations.kAddress]        = "123 Main Street"
        record[OneandDoneLocations.kDescription]    = " No code is needed for test. Please wait for update"
        record[OneandDoneLocations.kWebsiteURL]     = "https://apple.com"
        record[OneandDoneLocations.kLocation]       = CLLocation(latitude: 40.752439483881844, longitude:  -73.9827304179071)
        record[OneandDoneLocations.kPhoneNum]       = "9176221099"
        
        return record
    }
}
