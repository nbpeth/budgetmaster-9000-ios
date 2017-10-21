import Foundation

protocol ServiceDelgateable{
    func fail(_ message: String)
    func success(response:Week)
    func success(response:[Expense])

}
