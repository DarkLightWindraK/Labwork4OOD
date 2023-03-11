import Foundation
import CryptoKit

protocol Protectable {
    func hash(message: String) -> String
}

class SHA256Protector: Protectable {
    func hash(message: String) -> String {
        String(describing: SHA256.hash(data: Data(message.utf8)))
    }
}

class MD5Protector: Protectable {
    func hash(message: String) -> String {
        String(describing: Insecure.MD5.hash(data: Data(message.utf8)))
    }
}

class SHA1Protector: Protectable {
    func hash(message: String) -> String {
        String(describing: Insecure.SHA1.hash(data: Data(message.utf8)))
    }
}

enum EncryptionType: String, CaseIterable {
    case SHA256, MD5, SHA1
}

class Crypter {
    let algorythm: Protectable
    
    init(algorythm: Protectable) {
        self.algorythm = algorythm
    }
    
    func crypt(message: String) -> String {
        algorythm.hash(message: message)
    }
}

func getCryptor(type: EncryptionType) -> Crypter {
    switch type {
    case .SHA256:
        return Crypter(algorythm: SHA256Protector())
    case .MD5:
        return Crypter(algorythm: MD5Protector())
    case .SHA1:
        return Crypter(algorythm: SHA1Protector())
    }
}

while true {
    print("Выберите тип шифрования: SHA256, MD5, SHA1 или exit, чтобы выйти")
    let operation = readLine()
    
    guard operation?.lowercased() != "exit" else { break }
    guard let enumType = EncryptionType(rawValue: operation?.uppercased() ?? "") else { continue }

    print("Напишите сообщение: ")
    let message = readLine() ?? ""
    print(getCryptor(type: enumType).crypt(message: message))
}



