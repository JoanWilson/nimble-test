import UIKit

public final class DetailView: UIView {
    
    internal lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Images/surveyBackground")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    internal lazy var surveyTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.text = "Working from home Check-In"
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    internal lazy var surveyDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "We would like to know how you feel about our work from home (WFH) experience."
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .left
        
        return label
    }()
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        backgroundColor = .red
        buildLayout()
    }
}

extension DetailView: ViewCoding {
    func setupHierarchy() {
        addSubview(backgroundImage)
        addSubview(surveyTitle)
        addSubview(surveyDescription)
    }
    
    func setupConstraints() {
        backgroundImageConstraints()
        surveyTitleConstraints()
        surveyDescriptionConstraints()
    }
    
    private func backgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func surveyTitleConstraints() {
        NSLayoutConstraint.activate([
            surveyTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            surveyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            surveyTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func surveyDescriptionConstraints() {
        NSLayoutConstraint.activate([
            surveyDescription.topAnchor.constraint(equalTo: surveyTitle.bottomAnchor, constant: 16),
            surveyDescription.leadingAnchor.constraint(equalTo: surveyTitle.leadingAnchor),
            surveyDescription.trailingAnchor.constraint(equalTo: surveyTitle.trailingAnchor)
        ])
    }
}

#Preview {
    DetailView()
}
