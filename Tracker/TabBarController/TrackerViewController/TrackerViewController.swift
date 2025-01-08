import UIKit

class TrackerViewController: UIViewController {
  
  // MARK: - Properties
  
  private var categories: [TrackerCategory] = []
  private var completedTrackers: [TrackerRecord] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupNavigationBar()
    setupUIElements()
    setupConstraints()
  }
  
  // MARK: - UI Elements
  
  private lazy var headerLabel: UILabel = {
    let label = UILabel()
    label.text = "Трекеры"
    label.textColor = UIColor(named: "YPBlack")
    label.font = UIFont.boldSystemFont(ofSize: 34)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var searchTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor(named: "YPLightGray")
    textField.layer.cornerRadius = 8
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.delegate = self
    
    let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 34))
    textField.leftView = leftPaddingView
    textField.leftViewMode = .always
    
    let container = createSearchPlaceholderContainer()
    textField.addSubview(container)
    
    NSLayoutConstraint.activate([
      container.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 8),
      container.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -8),
      container.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
    ])
    
    textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    return textField
  }()
  
  private lazy var stubView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    let imageView = UIImageView(image: UIImage(named: "Stub"))
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let label = UILabel()
    label.text = "Что будем отслеживать?"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(imageView)
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 80),
      imageView.heightAnchor.constraint(equalToConstant: 80),
      
      label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
      label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    return view
  }()
  
  private lazy var leftBarButton: UIBarButtonItem = {
    let button = UIButton()
    button.setImage(UIImage(named: "ButtonPlus"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
    container.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalToConstant: 42),
      button.heightAnchor.constraint(equalToConstant: 42),
      button.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      button.centerYAnchor.constraint(equalTo: container.centerYAnchor)
    ])
    
    return UIBarButtonItem(customView: container)
  }()
  
  private lazy var rightBarButton: UIBarButtonItem = {
    let label = createRightLabel()
    return UIBarButtonItem(customView: label)
  }()
  
  // MARK: - Setup Methods
  
  private func setupNavigationBar() {
    navigationItem.leftBarButtonItem = leftBarButton
    navigationItem.rightBarButtonItem = rightBarButton
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func setupUIElements() {
    view.addSubview(headerLabel)
    view.addSubview(searchTextField)
    view.addSubview(stubView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      
      searchTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 7),
      searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      searchTextField.heightAnchor.constraint(equalToConstant: 34),
      
      stubView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      stubView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 220)
    ])
  }
  
  // MARK: - Helpers
  
  private func createSearchPlaceholderContainer() -> UIView {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    
    let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    searchIcon.tintColor = UIColor(named: "YPGray")
    searchIcon.translatesAutoresizingMaskIntoConstraints = false
    
    let placeholderLabel = UILabel()
    placeholderLabel.text = "Поиск"
    placeholderLabel.textColor = UIColor(named: "YPGray")
    placeholderLabel.font = UIFont.systemFont(ofSize: 17)
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    
    container.addSubview(searchIcon)
    container.addSubview(placeholderLabel)
    
    NSLayoutConstraint.activate([
      searchIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
      searchIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      searchIcon.widthAnchor.constraint(equalToConstant: 16),
      searchIcon.heightAnchor.constraint(equalToConstant: 16),
      
      placeholderLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8),
      placeholderLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      placeholderLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
    ])
    
    return container
  }
  
  private func createRightLabel() -> UILabel {
    let label = UILabel()
    label.backgroundColor = UIColor(named: "YPLightGray")
    label.textColor = UIColor(named: "YPBlack")
    label.font = UIFont.systemFont(ofSize: 17)
    label.textAlignment = .center
    label.layer.cornerRadius = 8
    label.layer.masksToBounds = true
    label.translatesAutoresizingMaskIntoConstraints = false
    
    let dateText = getCurrentDateText()
    label.text = dateText
    
    let textWidth = (dateText as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width
    let labelWidth = textWidth + 11
    NSLayoutConstraint.activate([
      label.heightAnchor.constraint(equalToConstant: 34),
      label.widthAnchor.constraint(equalToConstant: labelWidth)
    ])
    
    return label
  }
  
  private func getCurrentDateText() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy"
    return dateFormatter.string(from: Date())
  }
  
  @objc private func textFieldEditingChanged(_ textField: UITextField) {
    guard let container = textField.subviews.first else { return }
    container.isHidden = !(textField.text ?? "").isEmpty
  }
}

// MARK: - UITextFieldDelegate

extension TrackerViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let text = textField.text, let range = Range(range, in: text) {
      let updatedText = text.replacingCharacters(in: range, with: string)
      print(updatedText)
    }
    return true
  }
}
