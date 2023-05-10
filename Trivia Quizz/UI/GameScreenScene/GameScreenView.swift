import SwiftUI

protocol GameScreenViewLogic {
    func onTextChange(newText: String)
}

struct GameScreenView: View {
    private var interactor: GameViewInteractor = GameViewInteractor()
    private var presenter = GameViewPresenter()
    
    @State var text = "teste"
    var body: some View {
        VStack {
            TextField("title", text: $text)
            Button(action: {
                interactor.fetchQuestions()                
            }) {
                       Text("clique aqui")
                   }
                   .padding(2)
                   .background(Color.white)
                   .border(Color.black, width: 1)
                   .cornerRadius(10)
        }.onAppear {
            interactor.presenter = presenter
            presenter.view = self
        }
    }
        
}

extension GameScreenView: GameScreenViewLogic {
    func onTextChange(newText: String) {
        self.text = newText
    }
}

struct GameScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreenView()
    }
}
