enum Gender {
    case Unknown, Male, Female
    
    static func parseGender(gender: String) -> Gender {
        switch gender {
        case "male":
            return .Male
        case "female":
            return .Female
        default:
            return .Unknown
        }
    }
}