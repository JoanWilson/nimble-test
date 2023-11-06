import UIKit

public final class SurveyListView: UIView {
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        label.text = formattedDate.uppercased()
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.text = "Today"
        label.textColor = .white
        
        return label
    }()
    
    public lazy var userPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Images/userPic")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 17
        
        return imageView
    }()
    
    public lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Images/surveyBackground")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    public lazy var surveyTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Working from home Check-In"
        label.textColor = .white
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var surveyDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "We would like to know how you feel about our work from home..."
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.textAlignment = .justified
        
        return label
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Logos/detailButton"), for: .normal)
        button.backgroundColor = .clear
        
        return button
    }()
    
    public lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        
        return pageControl
    }()
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        buildLayout()
    }
}

extension SurveyListView: ViewCoding {
    
    func setupHierarchy() {
        addSubview(backgroundImage)
        addSubview(surveyDescription)
        addSubview(detailButton)
        addSubview(surveyTitle)
        addSubview(pageControl)
        addSubview(title)
        addSubview(descriptionTitle)
        addSubview(userPicture)
    }
    
    func setupConstraints() {
        backgroundImageConstraints()
        surveyDescriptionConstraints()
        detailButtonConstraints()
        surveyTitleConstraints()
        pageControlConstaints()
        titleConstraints()
        descriptionTitleConstraints()
        userPictureConstraints()
    }
    
    private func backgroundImageConstraints() {
        backgroundImage.constraintToSuperView()
    }
    
    private func surveyTitleConstraints() {
        NSLayoutConstraint.activate([
            surveyTitle.bottomAnchor.constraint(equalTo: detailButton.topAnchor),
            surveyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            surveyTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func surveyDescriptionConstraints() {
        NSLayoutConstraint.activate([
            surveyDescription.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            surveyDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            surveyDescription.trailingAnchor.constraint(equalTo: detailButton.leadingAnchor, constant: -20),
            surveyDescription.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
    
    private func detailButtonConstraints() {
        NSLayoutConstraint.activate([
            detailButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            detailButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            detailButton.bottomAnchor.constraint(equalTo: surveyDescription.bottomAnchor),
            detailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func pageControlConstaints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: surveyTitle.topAnchor, constant: -8),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -15),
        ])
    }
    
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: descriptionTitle.leadingAnchor),
            title.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 4)
        ])
    }
    
    private func descriptionTitleConstraints() {
        NSLayoutConstraint.activate([
            descriptionTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            descriptionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    private func userPictureConstraints() {
        NSLayoutConstraint.activate([
            userPicture.heightAnchor.constraint(equalToConstant: 36),
            userPicture.widthAnchor.constraint(equalToConstant: 36),
            userPicture.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            userPicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
