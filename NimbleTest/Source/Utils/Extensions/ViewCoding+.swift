import Foundation

protocol ViewCoding {
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
    }
}
