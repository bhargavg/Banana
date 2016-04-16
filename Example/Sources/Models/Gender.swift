import Banana

enum Gender {
    case Unknown, Male, Female
    
    /// Mapping from JSON to this model
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
    
    /// Mapping from this model to JSON
    static func toJSON(gender: Gender) -> String {
        switch gender {
        case .Male:
            return "male"
        case .Female:
            return "female"
        default:
            return "unknown"
        }
    }
}