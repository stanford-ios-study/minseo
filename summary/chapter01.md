#### Developing Apps for iOS - CS193P (iOS 11 Swift 4)

the fall term, 2017 

## Lecture 01. Overview of iOS



#### What's in iOS  

- **Cocoa Touch** - UI layer로 사용자와 가깝다. 버튼, 슬라이더나 Map Kit 등 UI에 관련된 다양한 부분을 지원한다.
- Media - 비디오, 오디오, 이미지 등을 다룬다. (본래 아이폰은 아이팟에 전화기능을 넣은 것이다.)
- **Core Services** - File Access, Networking 등 하위 서비스들의 최상위에 있는 객체지향층이다.
- Core OS - 하드웨어에 가깝다. iOS는 BSD 계열 Unix 기반이다.



#### Platform Componets

- Framework - 객체들의 집합. 
  - UIKit - 버튼 등 UI 관련 프레임워크.
  - Foundation -  코어 서비스와 관련된 모든 것.
- Design Strategy - MVC 



#### Demo - Concentration app

- IBOulet : 속성을 만든다.

- IBAction : 액션을 만든다.

- 유의점 : Any 를 해당 객체로 바꿀 것, Connections 확인

- 모든 인스턴스 변수(속성)는 초기화되어야 한다.

- Swift는 타입에 매우 엄격하며, 타입추론을 지원한다. Objective-C와의 호환을 위해 타입이 없는 경우가 종종 있지만, 거의 모든 변수는 타입을 갖는다.

- Property Observer : 속성 감시자. 모든 속성은 속성의 변화를 감지하는 속성 감시자를 사용할 수 있다. UI와 인스턴스 변수의 싱크를 맞추기 위해 자주 사용된다.

  ````swift
      var flipCount = 0 {
          // 속성 감시자 : flipCount가 바뀔 때마다 didSet을 실행하여 Label과 싱크를 맞추어 업데이트한다.
          didSet {
              flipCountLabel.text = "Flips: \(flipCount)"
          }
      }
  ````

- Oulet Collection == Array (배열은 제네릭 클래스다.)

  ````swift
  	// Oulet Collection
      @IBOutlet var cardButons: [UIButton]!
  	@IBOutlet var cardButons: Array<UIButton>!
  ````

- var : 변수 / let : 상수

- Optional

  - 설정된 것과 설정되지 않은 두 가지 상태의 열거형
  - 열거형 : 불연속형 값들의 모음. 각 케이스마다 관련된 데이터를 가질 수 있다.
  - nil : 설정되지 않은 옵셔널
