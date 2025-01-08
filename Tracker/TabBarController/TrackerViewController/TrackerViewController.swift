import UIKit

class TrackerViewController: UIViewController {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    setupNavigationBarItems()
    setupSubviews()
    setupConstraints()
  }
  
  // MARK: - Private Properties
  
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
    configureSearchTextField(textField)
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
  
  // MARK: - Private Methods
  
  private func configureView() {
    view.backgroundColor = .white
  }
  
  private func setupNavigationBarItems() {
    navigationItem.leftBarButtonItem = leftBarButton
    navigationItem.rightBarButtonItem = rightBarButton
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func setupSubviews() {
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
      
      stubView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 220),
      stubView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stubView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func configureSearchTextField(_ textField: UITextField) {
    textField.leftViewMode = .always
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 34))
    textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
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
    
    label.text = getCurrentDateText()
    let textWidth = (label.text! as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width
    label.widthAnchor.constraint(equalToConstant: textWidth + 16).isActive = true
    label.heightAnchor.constraint(equalToConstant: 34).isActive = true
    
    return label
  }
  
  private func getCurrentDateText() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yy"
    return formatter.string(from: Date())
  }
  
  @objc private func textFieldEditingChanged(_ textField: UITextField) {
    let isEmpty = (textField.text ?? "").isEmpty
    textField.subviews.first?.isHidden = !isEmpty
  }
}

// MARK: - UITextFieldDelegate

extension TrackerViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    if let range = Range(range, in: currentText) {
      let updatedText = currentText.replacingCharacters(in: range, with: string)
      print(updatedText)
    }
    return true
  }
}
