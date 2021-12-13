import UIKit

class EditStockViewController: UIViewController {
    private var fruitStore: FruitStore?
    
    @IBOutlet private var stockOfStrawberryLabel: UILabel!
    @IBOutlet private var stockOfBananaLabel: UILabel!
    @IBOutlet private var stockOfPineappleLabel: UILabel!
    @IBOutlet private var stockOfKiwiLabel: UILabel!
    @IBOutlet private var stockOfMangoLabel: UILabel!
    @IBOutlet private var strawberryStepper: UIStepper!
    @IBOutlet private var bananaStepper: UIStepper!
    @IBOutlet private var pineappleStepper: UIStepper!
    @IBOutlet private var kiwiStepper: UIStepper!
    @IBOutlet private var mangoStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationButton()
        updateStockLabel()
        updateStepperValue()
        setAccessibilityToStepper()
    }
    
    private func configureNavigationButton() {
        navigationItem.title = "재고 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(hitDoneButton))
    }
    
    private func setAccessibilityToStepper() {
        strawberryStepper.accessibilityLabel = "야곰야곰야곰"

    }
    
    @objc
    private func hitDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configure(fruitStore: FruitStore) {
        self.fruitStore = fruitStore
    }
    
    private func updateStockLabel() {
        let stringOfFruitStock: [Fruit: String]? = fruitStore?.fruitStock.mapValues { String($0) }
        guard let currentStock = stringOfFruitStock else {
            return
        }
        for (fruit, stock) in currentStock {
            switch fruit {
            case .strawberry:
                stockOfStrawberryLabel.text = stock
            case .banana:
                stockOfBananaLabel.text = stock
            case .pineapple:
                stockOfPineappleLabel.text = stock
            case .kiwi:
                stockOfKiwiLabel.text = stock
            case .mango:
                stockOfMangoLabel.text = stock
            }
        }
    }
    
    private func updateStepperValue() {
        strawberryStepper.value = Double(fruitStore?.fruitStock[.strawberry] ?? 0)
        bananaStepper.value = Double(fruitStore?.fruitStock[.banana] ?? 0)
        pineappleStepper.value = Double(fruitStore?.fruitStock[.pineapple] ?? 0)
        kiwiStepper.value = Double(fruitStore?.fruitStock[.kiwi] ?? 0)
        mangoStepper.value = Double(fruitStore?.fruitStock[.mango] ?? 0)
    }

    @IBAction private func hitStrawberryStepper(_ sender: UIStepper) {
        let value = Int(strawberryStepper.value)
        fruitStore?.changeQuantity(of: .strawberry, to: value)
        stockOfStrawberryLabel.text = String(value)
    }
    
    @IBAction private func hitBananaStepper(_ sender: UIStepper) {
        let value = Int(bananaStepper.value)
        fruitStore?.changeQuantity(of: .banana, to: value)
        stockOfBananaLabel.text = String(value)
    }
    
    @IBAction private func hitPineappleStepper(_ sender: UIStepper) {
        let value = Int(pineappleStepper.value)
        fruitStore?.changeQuantity(of: .pineapple, to: value)
        stockOfPineappleLabel.text = String(value)
    }
    
    @IBAction private func hitKiwiStepper(_ sender: UIStepper) {
        let value = Int(kiwiStepper.value)
        fruitStore?.changeQuantity(of: .kiwi, to: value)
        stockOfKiwiLabel.text = String(value)
    }
    
    @IBAction private func hitMangoStepper(_ sender: UIStepper) {
        let value = Int(mangoStepper.value)
        fruitStore?.changeQuantity(of: .mango, to: value)
        stockOfMangoLabel.text = String(value)
    }
}
