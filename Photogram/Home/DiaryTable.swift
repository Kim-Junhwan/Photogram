//
//  DiaryTable.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/09/16.
//

import Foundation
import RealmSwift

class DiaryTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var diaryTitle: String
    @Persisted var diaryDate: Date
    @Persisted var hasImage: Bool
    
    convenience init(diaryTitle: String, hasImage: Bool) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryDate = Date()
        self.hasImage = hasImage
    }
}
