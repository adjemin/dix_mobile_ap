package com.adjemin.dix

import com.adjemin.dix.properties.*

data class DixContact(
        var id: String,
        var displayName: String,
        var photo: ByteArray? = null,
        var name: Name = Name(),
        var phones: List<Phone> = listOf(),
        var emails: List<Email> = listOf(),
        var addresses: List<Address> = listOf(),
        var organizations: List<Organization> = listOf(),
        var websites: List<Website> = listOf(),
        var socialMedias: List<SocialMedia> = listOf(),
        var events: List<Event> = listOf(),
        var notes: List<Note> = listOf(),
        var accounts: List<Account> = listOf()) {

    companion object {
        fun fromMap(m: Map<String, Any?>): DixContact {
            return DixContact(
                    m["id"] as String,
                    m["displayName"] as String,
                    m["photo"] as? ByteArray,
                    Name.fromMap(m["name"] as Map<String, Any>),
                    (m["phones"] as List<Map<String, Any>>).map { Phone.fromMap(it) },
                    (m["emails"] as List<Map<String, Any>>).map { Email.fromMap(it) },
                    (m["addresses"] as List<Map<String, Any>>).map { Address.fromMap(it) },
                    (m["organizations"] as List<Map<String, Any>>).map { Organization.fromMap(it) },
                    (m["websites"] as List<Map<String, Any>>).map { Website.fromMap(it) },
                    (m["socialMedias"] as List<Map<String, Any>>).map { SocialMedia.fromMap(it) },
                    (m["events"] as List<Map<String, Any>>).map { Event.fromMap(it) },
                    (m["notes"] as List<Map<String, Any>>).map { Note.fromMap(it) },
                    (m["accounts"] as List<Map<String, Any>>).map { Account.fromMap(it) }
            )
        }
    }

    fun toMap(): Map<String, Any?> = mapOf(
            "id" to id,
            "displayName" to displayName,
            "photo" to photo,
            "name" to name.toMap(),
            "phones" to phones.map { it.toMap() },
            "emails" to emails.map { it.toMap() },
            "addresses" to addresses.map { it.toMap() },
            "organizations" to organizations.map { it.toMap() },
            "websites" to websites.map { it.toMap() },
            "socialMedias" to socialMedias.map { it.toMap() },
            "events" to events.map { it.toMap() },
            "notes" to notes.map { it.toMap() },
            "accounts" to accounts.map { it.toMap() }
    )


}