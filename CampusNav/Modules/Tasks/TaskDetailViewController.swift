final class TaskDetailViewController: UIViewController {
    private let task: (t: String, s: String, d: String, task: String, isUrgent: Bool)
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let subjectLabel = UILabel()
    private let infoStackView = UIStackView()
    private let descriptionLabel = UILabel()
    
    init(task: (t: String, s: String, d: String, task: String, isUrgent: Bool)) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupUI()
        setupConstraints()
        configureData()
    }
    
    private func setupUI() {
        subjectLabel.font = .systemFont(ofSize: 28, weight: .bold)
        subjectLabel.numberOfLines = 0
        
        infoStackView.axis = .vertical
        infoStackView.spacing = 15
        
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .label
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [subjectLabel, infoStackView, descriptionLabel].forEach { contentView.addSubview($0) }
    }
    
    private func configureData() {
        subjectLabel.text = task.s
        descriptionLabel.text = task.task
        
        addInfoRow(icon: "person.fill", text: task.t, color: .systemBlue)
        addInfoRow(icon: "calendar", text: "Сдать до: \(task.d)", color: task.isUrgent ? .systemRed : .systemGreen)
    }
    private func addInfoRow(icon: String, text: String, color: UIColor) {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 10
        
        let imageView = UIImageView(image: UIImage(systemName: icon))
        imageView.tintColor = color
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.size.equalTo(24) }
        
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(label)
        infoStackView.addArrangedSubview(container)
    }
}

extension TaskDetailViewController {
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        subjectLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}