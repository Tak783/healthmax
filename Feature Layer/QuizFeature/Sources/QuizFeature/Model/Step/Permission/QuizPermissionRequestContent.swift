//
//  QuizPermissionRequestContent.swift
//  QuizFeature
//
//  Created by Tak Mazarura on 22/05/2025.
//

import CorePresentation
import Foundation

public struct QuizPermissionRequestContent: StepInfoModellable, Codable, Sendable {
    public var question: String
    public let answerType: QuizAnswerType
    public let permissionRequestType: PermissionRequestType
    public let image: LocalImage
    public let title: String
    public let detail: String
}
