//
//  DateFormatter+Extensions.swift
//  Goats
//
//  Created on 18/03/2023.
//

import Foundation

extension DateFormatter {
    public static let jsonDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // From https://nsdateformatter.com : Best Practices Page
        // Always use the en_US_POSIX locale for fixed formats
        // If you don't force the locale to en_US_POSIX, there are risks that your code
        // might seem to work in some regions (like the US), but will fail to parse your API
        // responses if the user has its phone set in another region (e.g. en_GB, en_ES or fr_FR),
        // where date formatting is different, or use 12-hour time and not 24-hour time.
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter 
    }()
}

// MARK: - Medium Date Formatters
extension DateFormatter {
    /// Returns a medium style date/time formatter in UTC locale.  i.e. `12 Jun 2022 07:33:43 +0000`
    /// Locale is `en_US_POSIX``
    public static let mediumUTCDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    /// Returns a medium style date/time formatter in the current locale.  i.e. `12 Jun 2022 07:33:43 +0000`
    /// Locale is current
    public static let mediumCurrentLocaleDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy HH:mm:ss"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
}

// MARK: - Short Date Formatters
extension DateFormatter {
    /// Returns a short style date/time formatter in UTC locale.  i.e. `2022-12-11` `yyyy-MM-dd"`
    /// Locale is  `en_US_POSIX`
    public static let shortUTCDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    /// Returns a short style date/time formatter in current locale.  i.e. `2022-12-11`
    /// Locale is  .current`
    public static let shortCurrentLocaleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
    
    /// Returns a short style date/time formatter in current locale.  i.e. `Sunday, Sep 3, 2023`
    /// Locale is  .current`
    public static let readableShortCurrentLocaleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
    
    /// Returns a short style date/time formatter in current locale.  i.e. `10 Jan 2024`
    /// Locale is  .current`
    public static let readableDayOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
    
    /// Month Date Formatter i.e. 2023 January
    public static let monthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
 
// MARK: - Time Only Date Formatters
extension DateFormatter {
    /// Returns a medium style date/time formatter in user's locale.  i.e. `12 Jun 2022 07:33:43 +0000`
    /// Locale is current to the device
    public static let timeInCurentLocaleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
}

// MARK: - Other Date Formatters
extension DateFormatter {
    /// Returns a medium style date/time formatter in user's locale.  i.e. `12 Jun 2022 07:33:43 +0000`
    /// Locale is current to the device
    public static let dayDateTimeCurrentLocaleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter
    }()
}
