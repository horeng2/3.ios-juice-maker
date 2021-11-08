## **🤝 Ground Rule**

**팀원**

- horeng2 (호랭이) 
- aCafela coffee (aCafela coffee)

**시간**

- 끝나는 시간 : ~ 오후 10시
- 쉬는 날 : 수, 토, 일

## **🌊 Step 0 - FlowChart**

![](https://i.imgur.com/tTh4Fu8.jpg)


## 📍구현사항 (간단하게)

- model
    - FruitStore
        - `frutiStock` : 과일의 재고를 담을 딕셔너리
        - `Array(repeating:count:)`, `uniqueKeysWithValues:zip`
            
            → 과일 재고 딕셔너리에 초기 재고값 10을 초기화한다.
            
        - `func changeQuantity(of fruit: Fruit, step: Int, by operation: Operation)`
            
            → 과일의 수량을 변경하는 메소드. `by opertation`에 따라서 덧셈 또는 뺄셈을 실행한다.
            
        - `func changeQuantity(of fruit: Fruit, to count: Int)`
            
            → 과일의 수량을 `count`의 값으로 교체한다.
            
        - `func isRemaining(of recipe: [Fruit : Int]) -> Bool`
            
            → 쥬스 제조에 필요한 과일 수량만큼 재고가 충분한지 확인하여 `Bool`값을 리턴한다.
            
    - JuiceMaker
        - `stringOfFruitStock`
            
            → 과일의 재고를 `String` 값으로 변환하는 연산프로퍼티
            
        - `func canMake(_ seletedJuice: Menu) -> Bool`
            
            → 주문이 들어온 메뉴의 필요 재료 수량을 확인하고, 과일 재고를 차감한다.
            
- ViewController
    - MenuViewController
        - `func updateStockLabel()`
            
            → 뷰의 Label에 과일 수량을 업데이트한다.
            
        - `func orderJuice(_ juice: Menu)`
            
            → `juiceMaker.canMake`을 실행하고 반환값(true or false)에 따라서 `showAlert`를 실행한다.
            
        - `func showAlert(isSuccess: Bool, message: String)`
            
            → `UIAlertController`를 사용하여 알림메세지를 띄우고, 보기의 선택에 따라서 다음 동작을 결정한다.
            
        - `func moveToEditViewController()`
            
            → `UIStoryboard` 상수와 `EditStockViewController` 상수를 선언하여 `fruitStore`의 값을 전달하고, `present`를 이용하여 화면 전환을 실행한다.
            
    - EditStockViewController
        - `func configureNavigationButton()`
            
            → 내비게이션바의 이름과 버튼의 이름 및 설정을 지정한다.
            
        - `func hitDoneButton()`
            
            → `dismiss`를 이용하여 모달 창을 닫는다.
            
        - `func updateStockLabel()`
            
            → 뷰의 Label에 과일 수량을 업데이트한다.
            
        - `func updateStepperValue()`
            
            → 뷰의 stepper에 과일 수량을 업데이트한다.
            
        - `@IBAction private func**hitStrawberryStepper(_ sender: UIStepper)`
            
            → stepper의 버튼이 눌려지면 과일의 재고를 변경하고, Label에 새로운 값을 업데이트한다.
            

## 📝고민했던 것들

- 적절한 네이밍에 대한 끝없는 고민
- 과일 재고의 초기값을 한번에 세팅하는 방법?
- 쥬스 제작 시 사용되는 과일의 개수를 어떻게 관리할지?
    
    → `Array(repeating:count:)`, `uniqueKeysWithValues:zip`  사용
    
- 쥬스 주문 성공 여부에 따라 달라지는 알림 메세지를 어떻게 구분할지
    
    → showAlert함수 매개변수로 isSuccess(성공여부)를 Bool값으로 입력하여 orderJuice함수 내에서 if문으로 구분
    

## ❗️개선사항

- stepper를 사용하는 방법
    - 처음에는 버튼과 비슷하게 생각하여 값을 계산해서 다시 넣어주는 함수를 쓰려고 했는데, 같이 공부하다보니 버튼과는 다르게 IBOutlet과 stepper의 값을 이용할 수 있다는 점을 깨달아서 이부분을 적용
- 접근제어에 관련한 고민
    - 프로젝트 코드 안에서 해당 객체에 접근할만한 가능성이 없는 경우에도 접근제어를 설정해주는 것이 바람직할까? 예시: `@IBAction private func`
        
        → 외부에서 호출이 필요한 경우만 public으로 사용하고 나머지는 모두 private으로 설정
        

## ❓궁금했던 것들

- 화면 사이의 데이터 공유에 관한 부분
    
    → 아래와 같은 방법들이 있다.
    
    - 프로퍼티
    - Segues
    - 함수를 이용한 역전달
    - Delegation
    - Closure
    - NotificationCenter
- weak가 @IBOutlet 등을 선언할때만 자동으로 붙는 이유는 뭘까?
    - `weak`, `strong` 중에 선택할 수 있는데, 디폴트는 `weak`이다.
    - `Strong`, `Weak` 는 ARC(Auto Reference Count)와 관련이 깊다.
    - `Strong`은 소유대상의 reference count를 1 증가시킴으로써 dealloc 되지 않도록 하고, `Weak` 는 reference count는 증가시키지 않고 소유함으로써 상호참조 발생을 막아 메모리 누수를 막기위해 사용
    - **IBOutlet에 Strong을 써야 하는 경우?**
        
        복잡한 뷰 Hierarchy를 가진 경우에는 `Weak` 대신 `Strong`을 써야만 하는 경우도 존재한다.깊은 뷰 Hierarchy 구조에서 모든 Connection이 `Weak`라고 한다면 중간쯤 있는 `View`가 어느 이유에서인지 `dealloc`이 된다면? 그 하위뷰들도 함께 `dealloc`이 된다.
        
    - **그렇다면 `weak`가 디폴트인 이유는?**
        
        메모리 부족. 메모리가 부족하면 `didReceiveMemoryWarning` 에서 main view를 `nil` 처리함으로써 main view를 포함한 subview들 까지 모두 dealloc 하여 메모리를 확보하는 동작을 구현한다. 
        
        이 경우에 IBOutlet `Strong`으로 Subview들을 갖고있다면, ViewController가 `Strong`으로 갖고있는 `Reference Count 1` 때문에 절대 최소 1 이하로 내려가질 않는다. 즉, 그 Subview의 ParentView가 nil이 되더라도 SubView는 dealloc되지 않게 된다. 보이지도 않는 뷰가 메모리를 차지하게 되어버리는 것.
        
    
    → 결론: 디폴트로 `Weak`를 사용하는 게 좋다. 그 외 특별한 상황(복잡한 뷰)과 같이 정말 필요할 때는 `Strong`으로 사용하면 된다. 
    

## ⚒Trouble Shooting 위주

- @IBAction, @IBOulet을 코드 상에서 삭제하더라도, 스토리보드에는 그대로 연결상태가 남아있어서 오류가 발생하는 경우가 있었다. 연결과 관련해서 오류가 뜬다면, 코드에서뿐만 아니라 스토리보드에서의 연결도 체크해봐야한다.
- Label의 글자가 중간에 잘리는 경우(예: 바나....주문)
    
    → 스토리보드의 Attributes inspector - Button 에서 Line Break를 Word Wrap으로 설정