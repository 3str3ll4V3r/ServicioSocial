import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var brailleText: String = ""
    @State private var feedback: String = ""
    @State private var attempts: Int = 0
    @State private var errors: [String] = []
    
    let brailleMap: [Character: String] = [
        "a": "⠁", "b": "⠃", "c": "⠉", "d": "⠙", "e": "⠑", "f": "⠋", "g": "⠛", "h": "⠓", "i": "⠊", "j": "⠚",
        "k": "⠅", "l": "⠇", "m": "⠍", "n": "⠝", "o": "⠕", "p": "⠏", "q": "⠟", "r": "⠗", "s": "⠎", "t": "⠞",
        "u": "⠥", "v": "⠧", "w": "⠺", "x": "⠭", "y": "⠽", "z": "⠵",
        "á": "⠷", "é": "⠿", "í": "⠽", "ó": "⠹", "ú": "⠪", "ü": "⠳"
    ]
    
    func convertLetter() {
        if inputText.count == 1, let braille = brailleMap[inputText.lowercased().first ?? " "] {
            brailleText = braille
            feedback = "¡Felicidades! Letra convertida exitosamente."
            errors.removeAll()
        } else {
            attempts += 1
            feedback = "Error: Caracter no válido."
            errors = [inputText]
        }
    }
    
    func convertName() {
        var brailleResult = ""
        var invalidChars: [String] = []
        
        for char in inputText.lowercased() {
            if let braille = brailleMap[char] {
                brailleResult += braille + " "
            } else {
                invalidChars.append(String(char))
            }
        }
        
        if invalidChars.isEmpty {
            brailleText = brailleResult
            feedback = "¡Felicidades! Nombre convertido exitosamente."
            errors.removeAll()
        } else {
            attempts += 1
            feedback = "Error: Caracteres no válidos encontrados (\(invalidChars.joined(separator: ", ")))."
            errors = invalidChars
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Conversor de Braille")
                .font(.largeTitle)
                .bold()
            
            TextField("Ingresa tu nombre o una letra", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button(action: convertLetter) {
                    Text("Convertir Letra")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
                Button(action: convertName) {
                    Text("Convertir Nombre")
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            
            if !brailleText.isEmpty {
                Text("Resultado en Braille: ")
                    .font(.title3)
                    .foregroundColor(.black)
                Text((brailleText))
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            if !feedback.isEmpty {
                Text(feedback)
                    .foregroundColor(errors.isEmpty ? .green : .red)
            }
            
            if attempts == 3 {
                Text("Has alcanzado el límite de intentos.")
                    .foregroundColor(.orange)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

