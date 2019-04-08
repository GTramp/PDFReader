//
//  CNContact+Extensions.swift
//  Aurora
//
//  Created by tramp on 2019/3/12.
//  Copyright © 2019 tramp. All rights reserved.
//

import Foundation
import Contacts

extension CNContact {
    
    /// update contact
    ///
    /// - Parameter contact: CNContact
    /// - Returns: CNMutableContact
    public func update(_ contact: CNContact) -> CNMutableContact? {
        guard let _contact = self.mutableCopy() as? CNMutableContact else { return nil}
        
        //    open var contactType: CNContactType
        
        //    open var namePrefix: String
        if namePrefix.isEmpty { _contact.namePrefix = contact.namePrefix }
        //    open var givenName: String
        if givenName.isEmpty { _contact.givenName = contact.givenName }
        //    open var middleName: String
        if middleName.isEmpty { _contact.middleName = contact.middleName }
        //    open var familyName: String
        if familyName.isEmpty { _contact.familyName = contact.familyName }
        //    open var previousFamilyName: String
        if previousFamilyName.isEmpty { _contact.previousFamilyName = contact.previousFamilyName }
        //    open var nameSuffix: String
        if nameSuffix.isEmpty { _contact.nameSuffix = contact.nameSuffix }
        //    open var nickname: String
        if nickname.isEmpty { _contact.nickname = contact.nickname }
        //    open var organizationName: String
        if organizationName.isEmpty { _contact.organizationName = contact.organizationName }
        //    open var departmentName: String
        if departmentName.isEmpty { _contact.departmentName = contact.departmentName }
        //    open var jobTitle: String
        if jobTitle.isEmpty { _contact.jobTitle = contact.jobTitle }
        //    open var phoneticGivenName: String
        if phoneticGivenName.isEmpty { _contact.phoneticGivenName = contact.phoneticGivenName }
        //    open var phoneticMiddleName: String
        if phoneticMiddleName.isEmpty { _contact.phoneticMiddleName = contact.phoneticMiddleName }
        //    open var phoneticFamilyName: String
        if phoneticFamilyName.isEmpty { _contact.phoneticFamilyName = contact.phoneticFamilyName }
        //    open var phoneticOrganizationName: String
        if  #available(iOS 10.0, *),phoneticOrganizationName.isEmpty { _contact.phoneticOrganizationName = contact.phoneticOrganizationName }
        //    open var note: String
        if note.isEmpty { _contact.note = contact.note }
        //    open var imageData: Data?
        if imageData == nil { _contact.imageData = contact.imageData }
        //    open var phoneNumbers: [CNLabeledValue<CNPhoneNumber>]
        if contact.phoneNumbers.count > 0 {
            var items = phoneNumbers
            contact.phoneNumbers.forEach { (item) in
                if items.contains(where: {$0.value.stringValue == item.value.stringValue}) == false { items.append(item) }
            }
            _contact.phoneNumbers = items
        }
        //    open var emailAddresses: [CNLabeledValue<NSString>]
        if contact.emailAddresses.count > 0 {
            var items = emailAddresses
            contact.emailAddresses.forEach { (item) in
                if items.contains(where: {$0.value == item.value}) == false { items.append(item) }
            }
            _contact.emailAddresses = items
        }
        //    open var postalAddresses: [CNLabeledValue<CNPostalAddress>]
        if contact.postalAddresses.count > 0 {
            var items = postalAddresses
            contact.postalAddresses.forEach { (item) in
                if items.contains(where: {$0.value == item.value}) == false { items.append(item) }
            }
            _contact.postalAddresses = items
        }
        //    open var urlAddresses: [CNLabeledValue<NSString>]
        if contact.urlAddresses.count > 0 {
            var items = urlAddresses
            contact.urlAddresses.forEach { (item) in
                if items.contains(where: {$0.value == item.value}) == false { items.append(item) }
            }
            _contact.urlAddresses = items
        }
        //    open var contactRelations: [CNLabeledValue<CNContactRelation>]
        if contact.contactRelations.count > 0 {
            var items = contactRelations
            contact.contactRelations.forEach { (item) in
                if items.contains(where: {$0.value.name == item.value.name}) == false { items.append(item) }
            }
            _contact.contactRelations = items
        }
        //    open var socialProfiles: [CNLabeledValue<CNSocialProfile>]
        if contact.socialProfiles.count > 0 {
            var items = socialProfiles
            contact.socialProfiles.forEach { (item) in
                if items.contains(where: {$0.value.username == item.value.username}) == false { items.append(item)}
            }
            _contact.socialProfiles = items
        }
        //    open var instantMessageAddresses: [CNLabeledValue<CNInstantMessageAddress>]
        if contact.instantMessageAddresses.count > 0 {
            var items = instantMessageAddresses
            contact.instantMessageAddresses.forEach { (item) in
                if items.contains(where: {$0.value.username == item.value.username}) == false { items.append(item)}
            }
            _contact.instantMessageAddresses = items
        }
        //    open var birthday: DateComponents?
        if birthday == nil { _contact.birthday = contact.birthday }
        //    open var nonGregorianBirthday: DateComponents?
        if nonGregorianBirthday == nil { _contact.nonGregorianBirthday = contact.nonGregorianBirthday}
        //    open var dates: [CNLabeledValue<NSDateComponents>]
        if contact.dates.count > 0 {
            var items = dates
            contact.dates.forEach { (item) in
                if items.contains(where: {$0.value == item.value}) == false { items.append(item) }
            }
            _contact.dates = items
        }
        
        return _contact
    }
    
    
}

