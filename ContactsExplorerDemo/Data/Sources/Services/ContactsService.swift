//
//  ContactsService.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Contacts
import Combine
import Sharing
import Models
import Utilities

public actor ContactsService {
    
    // MARK: Properties
    
    @Shared(.allContacts)
    public private(set) var allContacts: [Contact] = []
    public private(set) var didRetrieveContacts: Bool = false
    
    // MARK: Computed Properties
    
    nonisolated public var authorization: ContactsAuthorization {
        switch authorizationStatus {
        case .authorized, .limited:
            .permitted
        case .denied, .restricted:
            .notPermitted
        case .notDetermined:
            .notDetermined
        @unknown default:
            .notDetermined
        }
    }
    
    nonisolated public var hasUserAuthorization: Bool {
        if #available(iOS 18.0, *) {
            authorizationStatus.includedIn(.authorized, .limited)
        } else {
            authorizationStatus.includedIn(.authorized)
        }
    }
    
    nonisolated private var authorizationStatus: CNAuthorizationStatus {
        CNContactStore.authorizationStatus(for: .contacts)
    }
    
    // MARK: Private Methods
    
    nonisolated private func mapPhoneNumberLabelType(from cnLabelRawValue: String) -> Contact.PhoneNumber.LabelType {
        switch cnLabelRawValue {
        case CNLabelPhoneNumberMain:
            .main
        case CNLabelPhoneNumberMobile:
            .mobile
        case CNLabelPhoneNumberAppleWatch:
            .appleWatch
        case CNLabelPhoneNumberHomeFax, CNLabelPhoneNumberWorkFax, CNLabelPhoneNumberOtherFax:
            .fax
        case CNLabelPhoneNumberPager:
            .pager
        default:
            .other
        }
    }
    
    nonisolated private func mapPhoneNumbers(for contact: CNContact) -> [Contact.PhoneNumber] {
        contact.phoneNumbers.map {
            let label = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: $0.label ?? .empty)
            let labelType = mapPhoneNumberLabelType(from: label)
            
            return Contact.PhoneNumber(
                label: label,
                labelType: labelType,
                number: $0.value.stringValue,
                isMain: $0.label == CNLabelPhoneNumberMain
            )
        }
    }
    
    nonisolated private func mapEmails(for contact: CNContact) -> [Contact.Email]? {
        contact.emailAddresses.map {
            Contact.Email(
                label: CNLabeledValue<NSString>.localizedString(forLabel: $0.label ?? .empty),
                address: $0.value as String
            )
        }
    }
    
    nonisolated private func mapJob(for contact: CNContact) -> Contact.Job? {
        guard contact.jobTitle.isNotEmpty else { return nil }
        return Contact.Job(
            title: contact.jobTitle,
            departmentName: contact.departmentName.isNotEmpty ? contact.departmentName : nil,
            organizationName: contact.organizationName.isNotEmpty ? contact.organizationName : nil
        )
    }
    
    private func setDidRetrieveContacts(with value: Bool) async {
        didRetrieveContacts = value
    }
    
    // MARK: Public Methods
    
    nonisolated public func retrieveContacts() async {
        guard hasUserAuthorization else { return }
        let store = CNContactStore()
        
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName) as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactImageDataKey as CNKeyDescriptor,
            CNContactThumbnailImageDataKey as CNKeyDescriptor,
            CNContactJobTitleKey as CNKeyDescriptor,
            CNContactDepartmentNameKey as CNKeyDescriptor,
            CNContactOrganizationNameKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor,
            CNContactBirthdayKey as CNKeyDescriptor
        ]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        fetchRequest.sortOrder = .userDefault
        var contacts: [Contact] = []
        
        do {
            try store.enumerateContacts(with: fetchRequest) { contact, _ in
                let mappedPhoneNumbers = mapPhoneNumbers(for: contact)
                let mappedEmails = mapEmails(for: contact)
                let job = mapJob(for: contact)
                
                let mappedContact = Contact(
                    id: contact.identifier,
                    imageData: contact.thumbnailImageData ?? contact.imageData,
                    firstName: contact.givenName,
                    lastName: contact.familyName,
                    phoneNumbers: mappedPhoneNumbers,
                    job: job,
                    emails: mappedEmails,
                    birthday: contact.birthday?.date
                )
                
                contacts.append(mappedContact)
            }
            
            await $allContacts.withLock { $0 = contacts }
            await setDidRetrieveContacts(with: true)
            
        } catch {
            // TODO: Handle error
            await $allContacts.withLock { $0 = [] }
            await setDidRetrieveContacts(with: true)
        }
    }
    
    public func requestContactsPermission() async -> Bool {
        switch authorizationStatus {
        case .authorized, .limited:
            return true
            
        default:
            return (try? await CNContactStore().requestAccess(for: .contacts)) ?? false
        }
    }
}
