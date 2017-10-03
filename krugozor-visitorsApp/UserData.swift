//
//  UserData.swift
//  anticafe-UserApp
//
//  Created by Анатолий on 25.09.17.
//  Copyright © 2017 OneByteCode. All rights reserved.

import CoreData

class UserData: NSManagedObject {

    static func saveUserData (userInfo: UserDataStruct, context: NSManagedObjectContext) {
        var userSaveInfo = UserData(context: context)
        userSaveInfo = saveData(from: userInfo, toCoreData: userSaveInfo)
        do {
            try context.save()
        } catch {
            print("Error in UserData.saveUserData - can't save context")
        }
    }

    static func restoreUserDataByCoincidences (predicateType: UserRequestType, predicateText: String, context: NSManagedObjectContext) -> UserDataStruct {
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        request.predicate = NSPredicate(format: "\(String(describing: predicateType)) == %@", predicateText)
        return requestToData(request: request, context: context)
    }

    static func restoreUserData (context: NSManagedObjectContext) -> UserDataStruct {
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        return requestToData(request: request, context: context)
    }
    
    static func restoreLastSession (context: NSManagedObjectContext) -> UserDataStruct {
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        request.predicate = NSPredicate(format: "session == true")
        return requestToData(request: request, context: context)
    }
    
    fileprivate static func requestToData (request: NSFetchRequest<UserData>, context: NSManagedObjectContext) -> UserDataStruct {
        do {
            let matches = try context.fetch(request)
            guard matches.count != 0 else {
                print("Error in UserData.requestToData - didn't found any account info")
                return UserDataStruct()
            }
            if matches.count > 1 {
                print("Error in UserData.requestToData - found more then 1 account info")
            } else {
                return UserDataStruct(userData: matches[0])
            }
        } catch {
            print("Error in UserData.requestToData - cant throw fetch request")
        }
        print("Error in UserData.requestToData - exit from nessesary clouser")
        return UserDataStruct()
    }

    /// Constructor for creating a model in CoreData
    fileprivate static func saveData (from userInfo: UserDataStruct, toCoreData userSave: UserData) -> UserData {
        let save = userSave
        save.name = userInfo.name
        save.surname = userInfo.surname
        save.session = userInfo.session
        if let age = userInfo.age {
            save.age = Int16(age)
        }
        save.email = userInfo.email
        if let data = userInfo.photoImageBanner {
            save.photoImageBanner = data
        }
        if let data = userInfo.photoImageOrigin {
            save.photoImageOrigin = data
        }
        save.photoURLBanner = userInfo.photoURLBanner
        save.photoURLOrigin = userInfo.photoURLOrigin
        if let gender = userInfo.gender {
            save.gender = gender
        }
        return save
    }
    
    /// Delete All User's
    static func deleteAllUsers(context: NSManagedObjectContext) {
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        do {
            let results = try? context.fetch(request)
            if let users = results {
                for user in users {
                    context.delete(user)
                }
            }
            try context.save()
        } catch {
            print ("Error in deleteAllUsers")
        }
    }
}
