# Tic Tac Toe

## 기술 스택
* SwiftUI

## 주요 기능
* 싱글/멀티 플레이
* 3가지 난이도 설정
* 플레이어 심볼 변경 기능
* 점수 표시 및 하이라이팅 기능

## 구현 내용
### 싱글 플레이 컴퓨터 구현
```swift
// 컴퓨터의 위치를 난이도에 따라 반환하는 함수
func determineComputerMovePosition() -> Int {
		// 난이도가 medium 이상일 경우
        if gameSetting.selectedDifficulty.level >= 2 {
	        // getFinalPiece(for:) - 인자로 주어진 플레이어가 승리할 수 있는 위치를 옵셔널 값으로 반환하는 함수.
	        // 컴퓨터가 승리할 수 있는 위치가 있다면 그 위치를 반환하여 승리한다.
            if let position = getFinalPiece(for: .player2) {
                return position
            }
        }
        
		// 난이도가 hard일 경우
        if gameSetting.selectedDifficulty.level == 3 {
            // 유저가 이길 수 있는 위치가 있다면 그 위치를 반환하여 유저가 승리하는 것을 막는다.
            if let position = getFinalPiece(for: .player1) {
                return position
            }
            
            // 유저가 이길 수 있는 위치가 없다면 게임에 유리한 가운데 위치를 반환.
            // isSquareOccupied(forIndex:) - 주어진 위치가 선점되었는지 확인하는 함수.
            let centerSquare = 4
            if !isSquareOccupied(forIndex: centerSquare) {
                return centerSquare
            }
        }
                
        // 난이도가 easy이거나 위의 조건들이 모두 일치하지 않았을 때 아무 위치나 랜덤으로 반환.
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
```
* 싱글플레이일 경우 난이도에 따라 컴퓨터의 위치를 결정하는 로직 구현.

### 플레이어 심볼 변경 기능 구현
<img width = "200" src = "https://github.com/user-attachments/assets/63c861a0-bdfa-47a5-9a08-d8096d653b36">

* SF symbol을 활용하여 유저가 원하는 심볼을 직접 선택할 수 있도록 구현.
* HIG 지침을 준수하여 심볼 변경 시 시트의 콘텐츠를 점진적으로 표시할 수 있도록, 즉 선택한 심볼이 적용되는 것을 유저가 볼 수 있도록 중형 디텐트를 지원하고 시트 오른쪽 상단에 dismiss 버튼 배치

### Dynamic Alert 구현
```swift
enum AlertType {
    case win(player: Player), draw, reset, exit
    
    var title: String {
        switch self {
        case .win(let player):
            "\(player.rawValue.capitalized) Win"
        case .draw:
            "Draw"
        case .reset:
            "Reset Game"
        case .exit:
            "Exit Game"
        }
    }
    
    var message: String {
        switch self {
        case .win(let player):
            "\(player.rawValue.capitalized) is so smart!"
        case .draw:
            "What a battle of wits we have here.."
        case .reset, .exit:
            "Are you sure?"
        }
    }
}

@State var alert: AlertType

var body: some View {
	/* ... */
	.alert(alert.title, isPresented: $isShowingAlert, presenting: alert) { alert in
            switch alert {
            case .reset:
                Button("OK") { resetGame() }
                Button("Cancel", role: .cancel) {}
            case .exit:
                Button("OK") { isPlaying = false }
                Button("Cancel", role: .cancel) {}
            case .win, .draw:
                Button("OK") { resetMoves() }
            }
        } message: { alert in
            Text(alert.message)
        }
}
```
* 게임 결과를 알리거나 게임을 초기화하거나 종료할 때 등 상황에 따라 각각 다른 스타일의 Alert를 표시하기 위해 dynamic alert 구현\

### 플레이어 순서 표시
<img width = "200" src = "https://github.com/user-attachments/assets/0dd3b2ba-3547-4d38-8698-9d39fd4a24d7">

```swift
struct ScoreView: View {
    
    var isPlayerTurn: Bool
    var symbol: String
    var score: Int
    
    var body: some View {
        HStack(spacing: 30) {
			/* ... */
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(isPlayerTurn ? .systemIndigo : .label), lineWidth: 3)
                .animation(.easeInOut, value: isPlayerTurn)
        }
    }
}
```

* 플레이어의 점수를 나타내는 뷰의 테두리를 강조하여 순서 표시
