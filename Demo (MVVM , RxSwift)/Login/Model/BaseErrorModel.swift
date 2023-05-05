//
//  BaseErrorModel.swift
//  Demo (MVVM , RxSwift)
//
//  Created by hamdi on 05/05/2023.
//

import Foundation

struct BaseErrorModel: Codable {
    let message: String?
    let status_code: Int?
}
