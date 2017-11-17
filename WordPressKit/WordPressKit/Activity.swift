import Foundation

public struct Activity {
    public let activityID: String
    public let summary: String
    public let name: String
    public let type: String
    public let gridicon: String
    public let status: String
    public let rewindable: Bool
    public let rewindID: String?
    public let published: Date
    public let actor: ActivityActor?
    public let object: ActivityObject?
    public let target: ActivityObject?
    public let items: [ActivityObject]?

    init(dictionary: [String: AnyObject]) throws {
        guard let id = dictionary["activity_id"] as? String else {
            throw Error.missingActivityId
        }
        guard let publishedString = dictionary["published"] as? String else {
            throw Error.missingPublishedDate
        }
        let dateFormatter = ISO8601DateFormatter()
        guard let publishedDate = dateFormatter.date(from: publishedString) else {
            throw Error.incorrectPusblishedDateFormat
        }
        activityID = id
        published = publishedDate
        summary = dictionary["summary"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        type = dictionary["type"] as? String ?? ""
        gridicon = dictionary["gridicon"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        rewindable = dictionary["is_rewindable"] as? Bool ?? false
        rewindID = dictionary["rewind_id"] as? String
        if let actorData = dictionary["actor"] as? [String: AnyObject] {
            actor = ActivityActor(dictionary: actorData)
        } else {
            actor = nil
        }
        if let objectData = dictionary["object"] as? [String: AnyObject] {
            object = ActivityObject(dictionary: objectData)
        } else {
            object = nil
        }
        if let targetData = dictionary["actor"] as? [String: AnyObject] {
            target = ActivityObject(dictionary: targetData)
        } else {
            target = nil
        }
        if let orderedItems = dictionary["items"] as? [[String: AnyObject]] {
            items = orderedItems.map { item -> ActivityObject in
                return ActivityObject(dictionary: item)
            }
        } else {
            items = nil
        }
    }
}

private extension Activity {
    enum Error: Swift.Error {
        case missingActivityId
        case missingPublishedDate
        case incorrectPusblishedDateFormat
    }
}

public struct ActivityActor {
    public let displayName: String
    public let type: String
    public let wpcomUserID: String
    public let avatarURL: String
    public let role: String

    init(dictionary: [String: AnyObject]) {
        displayName = dictionary["name"] as? String ?? ""
        type = dictionary["type"] as? String ?? ""
        wpcomUserID = dictionary["wp_com_user_id"] as? String ?? ""
        if let iconInfo = dictionary["icon"] as? [String: AnyObject] {
            avatarURL = iconInfo["url"] as? String ?? ""
        } else {
            avatarURL = ""
        }
        role = dictionary["role"] as? String ?? ""
    }
}

public struct ActivityObject {
    public let name: String
    public let type: String
    public let attributes: [String: Any]

    init(dictionary: [String: AnyObject]) {
        name = dictionary["name"] as? String ?? ""
        type = dictionary["type"] as? String ?? ""
        let mutableDictionary = NSMutableDictionary(dictionary: dictionary)
        mutableDictionary.removeObjects(forKeys: ["name", "type"])
        if let extraAttributes = mutableDictionary as? [String: Any] {
            attributes = extraAttributes
        } else {
            attributes = [:]
        }
    }
}

public struct ActivityName {
    public static let fullBackup = "rewind__backup_complete_full"
}

public struct RestoreStatus {
    public let status: Status
    public let percent: Int
    public let message: String?
    public let errorCode: String?
    public let failureReason: String?

    init(dictionary: [String: AnyObject]) throws {
        guard let restoreStatus = dictionary["status"] as? String else {
            throw Error.missingRestoreStatus
        }
        guard let restoreStatusEnum = Status(rawValue: restoreStatus) else {
            throw Error.invalidRestoreStatus
        }
        guard let percentCompleted = dictionary["percent"] as? Int else {
            throw Error.missingRestorePercent
        }
        status = restoreStatusEnum
        percent = percentCompleted
        message = dictionary["message"] as? String
        errorCode = dictionary["error_code"] as? String
        failureReason = dictionary["failure_reason"] as? String
    }
}

public extension RestoreStatus {
    enum Status: String {
        case queued
        case finished
        case running
        case fail
    }
}

extension RestoreStatus {
    enum Error: Swift.Error {
        case missingRestoreStatus
        case invalidRestoreStatus
        case missingRestorePercent
    }
}
