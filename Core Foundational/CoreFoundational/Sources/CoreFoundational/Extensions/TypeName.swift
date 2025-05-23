//
//  TypeName
//  CoreFoundational
//
//  Created by Tak Mazarura on 25/04/2025.
//

public struct TypeNameHelper {
    public static func name<T>(of type: T.Type) -> String {
        String(describing: type)
    }
}
