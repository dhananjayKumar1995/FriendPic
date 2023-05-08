//
//  String+Extension.swift
//  SampleProject
//
//  Created by RAVI K GUPTA on 04/01/22.
//

import UIKit

extension String {
    
   
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType:NSAttributedString.DocumentType.html,.characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch  {
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = "^[0-9]{6,15}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
        return valid
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func validateEmailForCharecter(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]{2,}@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return enteredEmail.range(of: emailFormat, options: .regularExpression) != nil
    }
    
//    func isValidPassword()-> Bool {
//        let regex = try! NSRegularExpression(pattern: "", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//    }
        func isValidPassword()-> Bool {
            
            let regex = try! NSRegularExpression(pattern: "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}")
               return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
           
           } //^(?=.{6,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$
    //"(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"
    //(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}
    //^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$
    //    func isContactNumberValid() -> Bool {
    //        if(self.characters.count >= 8 && self.characters.count <= 16){
    //            return true
    //        }
    //        else{
    //            return false
    //        }
    //    }
    
    
    static func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...9).map{ _ in letters.randomElement()! })
    }
    
    static func getString(_ value: Int?) -> String{
        if let value = value {
            return "\(value)"
        }
        return ""
    }
    
//    func isValidPassword(testStr:String?) -> Bool {
//        guard testStr != nil else { return false }
//
//        // at least one uppercase,
//        // at least one digit
//        // at least one lowercase
//        // 8 characters total
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
//        return passwordTest.evaluate(with: testStr)
//    }
    
    func charactorCount(str: String) -> Int {
        let s = str.count
        return s
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: " \n", options:
                                            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
                                                                                                    "", options:.regularExpression, range: nil)
    }
    func checkForValidLength(min: Int, max: Int) -> Bool{
        return self.count >= min && self.count <= max
    }
    static func join(strings: [String?]?, separator: String) -> String {
        guard let strings = strings else{return ""}
        return strings.compactMap { $0 }.joined(separator: separator)
    }
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "", size: 16)!, range: range)
        }
        guard let characterSpacing = characterSpacing else {return attributedString}
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    func setAttributedTextForAsteric(color: UIColor, font: UIFont?)->NSMutableAttributedString{
        let range = (self as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        if let font = font {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        }
        return attributedString
    }
    func isNameValid() -> Bool{
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "[A-Za-z ]{3,50}"//"^\\w{3,50}$"
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    func isFullNameValid()-> Bool{
        return false

    }
    func isUserNameValid()-> Bool{
      return true
        
    }
    func isLengthValid(minLength: Int , maxLength: Int) -> Bool {
        return self.count >= minLength && self.count <= maxLength
    }
    

    func getValues(separatedBy: String) -> [String]?{
        return self.components(separatedBy: separatedBy)
    }
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
    
    func getTimeUsingTimeStamp() -> String {
        
        let epochTime = TimeInterval(Double(self) ?? 0.0) / 1000
        let dateFromServer = Date(timeIntervalSince1970: epochTime)
        
        let endDate = Date()
        let indian = Calendar(identifier: .indian)
        let components =  indian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateFromServer , to: endDate)
        let years = components.year
        let months = components.month
        let days = components.day
        
        let dateFormater = DateFormatter()
        
        if Calendar.current.isDateInToday(dateFromServer as Date) {
            dateFormater.dateFormat = "hh:mm a"
        }
        else if Calendar.current.isDateInYesterday(dateFromServer as Date) {
            dateFormater.dateFormat = "'Yesterday'"//"'Yesterday' hh:mm a"
        }
        else {
            dateFormater.dateFormat = "dd-MMM-yyyy hh:mm a"
        }
        
        
        if years == 0 {
            if months == 0 {
                if days ?? 0 <= 1 {
                    if Calendar.current.isDateInToday(dateFromServer as Date) {
                        dateFormater.dateFormat = "hh:mm a"
                    }
                    else{
                        dateFormater.dateFormat = "'Yesterday'"
                    }
                } else {
                    let dyas = String.getString(days)
                    if let day = Int(dyas) , day < 7 {
                        dateFormater.dateFormat = "EEEE"
                    }
                    else {
                        dateFormater.dateFormat = "dd MMM"
                    }
                }
            } else {
                dateFormater.dateFormat = "dd MMM"
            }
        } else {
                dateFormater.dateFormat = "dd-MM-yyyy"
        }
        
        return dateFormater.string(from: dateFromServer as Date)
        
    }
    
}
extension String{
    // validations

    static func checkForEmailValidationErrorMessage(value: String?) -> (value: String?, message: String?){
        guard let email = value, !email.isEmpty else{return (value: nil, message: ErrorMessages.emptyEmail)}
        if !email.isValidEmail(){
            return (value: nil, message: ErrorMessages.invalidEmail)
        }
        return (value: email, message: nil)
    }
    
    static func checkForJobTitleErrorMessage(value: String?) -> (value: String?, message: String?){
        guard let email = value, !email.isEmpty else{return (value: nil, message: ErrorMessages.emptyJobTitle)}
        return (value: email, message: nil)
    }

    static func checkForJobTitleErrorMessage(value: String?) -> String?{
        guard let name = value, !name.isEmpty else{return ErrorMessages.emptyJobTitle}
        let parts = name.components(separatedBy: " ")
        if parts.count > 2 {
            return ErrorMessages.firstLastNameAllowed
        }
        for name in parts{
            if !name.isNameValid(){
                return ErrorMessages.invalidName
            }
        }
        return nil
    }
    
    
    static func checkForPasswordValidationErrorMessage(value: String?) -> (value: String?, message: String?){
        guard let password = value, !password.isEmpty else{return  (value: nil, message: ErrorMessages.emptyPassword)}
        guard password.count > 5 else {return (value: nil, message: "Password should be more than 6 character long")}
        if !password.isValidPassword(){
            return (value: nil, message: ErrorMessages.invalidPassword)
        }
        return (value: password, message: nil)
        
    }
    static func checkForConfirmPasswordValidationErrorMessage(value: String?) -> (value: String?, message: String?){
        guard let password = value, !password.isEmpty else{return  (value: nil, message: ErrorMessages.emptyConfirmPassword)}
        guard password.count > 5 else {return (value: nil, message: "Confirm password should be more than 6 character long")}
        if !password.isValidPassword(){
            return (value: nil, message: ErrorMessages.invalidPassword)
        }
        return (value: password, message: nil)
        
    }
    static func checkForNameValidationErrorMessage(value: String?) -> String?{
        guard let name = value, !name.isEmpty else{return ErrorMessages.emptyName}
        let parts = name.components(separatedBy: " ")
        if parts.count > 2 {
            return ErrorMessages.firstLastNameAllowed
        }
        for name in parts{
            if !name.isNameValid(){
                return ErrorMessages.invalidName
            }
        }
        return nil
    }
    static func checkForNumberValidationErrorMessage(value: String?) -> String?{
        guard let number = value, !number.isEmpty else{return ErrorMessages.emptyNumber}
        guard (Int(number) != nil) else {return ErrorMessages.numberAllowed}
        if !number.isValidPhoneNumber(){
            return ErrorMessages.invalidNumberLength
        }
        return nil
    }
    
}
struct ErrorMessages{
    
    static let emptyJobTitle = "Please enter job title."
    static let emptyEmail = "Please enter Email."
    static let invalidEmail = "Please enter valid email."
    static let shouldNotHappen = "This should not happen"
    static let emptyPassword = "Please enter Password."
    static let emptyConfirmPassword = "Please enter the confirm password"
    static let invalidPassword = "Password should contain this and that"
    static let emptyName = "Please enter name."
    static let firstLastNameAllowed = "Only first and last names are allowed."
    static let invalidName = "Length be 18 characters max and 3 characters minimum"
    static let emptyNumber = "Please enter number."
    static let numberAllowed = "Only numbers are allowed."
    static let invalidNumberLength = "Phone number should be 6 to 15 digit long"

}



// MARK: - Extension of Dictionary For getting the different types of values from it.
extension Dictionary {
    
    /// This method is used to get the string value from the dictionary.
    ///
    /// - Parameter key: Pass the key for which you want to get the value.
    /// - Returns: return String value according to passed key.
    func valueForString(key:String) -> String {
        
        if let dictionary = self as? [String:Any] {
            
            return "\(dictionary[key] ?? "")"
            
        } else {
            return ""
        }
    }
    
    
    func valueForInt(key:String) -> Int? {
        return self.valueForString(key: key).toInt
    }
    
    /// This method is used to get the Int value from the dictionary.
    ///
    /// - Parameter key: Pass the key for which you want to get the value.
    /// - Returns: This Method returns Int? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("Int!") then application will crash.
//    func valueForInt(key:String) -> Int? {
//        return self.valueForString(key: key).toInt
//    }
    
//    func valueForDouble(key:String) -> Double? {
//        return self.valueForString(key: key).toDouble
//    }
    
//    func valueForFloat(key:String) -> Float? {
//        return self.valueForString(key: key).toFloat
//    }
    
    /// This method is used to get the Any value from the dictionary.
    ///
    /// - Parameter key: Pass the key for which you want to get the value.
    /// - Returns: This Method returns Any? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("Any!") then application will crash.
    func valueForJSON(key:String) -> Any? {
        
        if let dictionary = self as? [String:Any] {
            
            return dictionary[key] ?? nil
            
        } else {
            return nil
        }
    }
    
    func valueForBool(key:String) -> Bool {
        
        if let dictionary = self as? [String:Any] {
            
            switch dictionary[key] {
            case let string as String:
                if string == "1" || string.lowercased() == "true" {
                    return true
                }
            case let int as Int:
                if int > 0  {
                    return true
                }
            case let bool as Bool:
                return bool
            default:
                return false
            }
            
        }
        
        return false
    }
    
   
    
}

extension String {
    
    /// A Computed Property (only getter) of Int For getting the Int? value from String.
    /// This Computed Property (only getter) returns Int? , it means this Computed Property (only getter) return nil value also , while using this Computed Property (only getter) please use if let. If you are not using if let and if this Computed Property (only getter) returns nil and when you are trying to unwrapped this value("Int!") then application will crash.
    var toInt:Int? {
        return Int(self)
    }
    
    var toDouble:Double? {
        return Double(self)
    }
    
    var toFloat:Float? {
        return Float(self)
    }
    
    
    /// A Computed Property (only getter) of URL For getting the URL from String.
    /// This Computed Property (only getter) returns URL? , it means this Computed Property (only getter) return nil value also , while using this Computed Property (only getter) please use if let. If you are not using if let and if this Computed Property (only getter) returns nil and when you are trying to unwrapped this value("URL!") then application will crash.
    var toURL:URL? {
        return URL(string: self)
    }
    
}

