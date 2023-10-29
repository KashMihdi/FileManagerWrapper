
import SwiftUI

@propertyWrapper
public struct FileManagerWrapper<T: Codable>: DynamicProperty {
    @State private var value: T?
    private let key: String
    
    public var wrappedValue: T? {
        get { value }
        nonmutating set { value = newValue }
    }
    
    public var projectedValue: T? {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }
    
    public init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = .init(wrappedValue: object)
        } catch {
            _value =  .init(wrappedValue: nil)
        }
    }
    
    private func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentPath(key: key))
            value = newValue
            print(NSHomeDirectory())
            print("SUCCESS SAVED")
        } catch {
            print("ERROR SAVING: \(error)")
        }
    }
}
