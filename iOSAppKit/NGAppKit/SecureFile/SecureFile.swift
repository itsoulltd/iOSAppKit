//
//  DNSecureFile.swift
//  StartupProjectSampleA
//
//  Created by Towhid on 8/26/15.
//  Copyright (c) 2015 Towhid (Selise.ch). All rights reserved.
//

import Foundation
import FileSystemSDK

@objc(SecureFile)
open class SecureFile: File {
    
    open func decrypt(password key: String, bufferSize bSize: Int = 1024, progress: IFileProgress? = nil, completionHandler: ((Data)->Void)? = nil){
        //Following Code is copied from https://github.com/RNCryptor/RNCryptor#async-and-streams
        //As Suggested by RNCrypto framework auther -> How to use encryption/decryption with RNCrypto API.
        //Actual code was written in Objective-C. Here we have converted into Swift.
        //Please, feel free to Copy/Modify folloing lines of code. RNCrypto API is MIT License.
        DispatchQueue.global().async(execute: { () -> Void in
            //
            var bufferSize = bSize
            if bSize < 1024{
                bufferSize = 1024
            }
            let blockSize = 2 * bufferSize
            let readStream: InputStream = InputStream(fileAtPath: self.URL.path)!
            let writeBuffer: NSMutableData = NSMutableData()
            
            readStream.open()
            
            var data = Data(count: blockSize)
            var decryptor: RNDecryptor? = nil
            var totalWritenLength: Int = 0
            
            let readStreamBlock: ()->() = { (Void) -> Void in
                
                let buffer = data.withUnsafeMutableBytes({ (ptr:UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> in
                    return ptr
                })
                let bytesRead = readStream.read(buffer, maxLength: blockSize)
                if bytesRead == 0{
                    readStream.close()
                    decryptor?.finish()
                }
                else if bytesRead > 0{
                    totalWritenLength += bytesRead
                    data.count = bytesRead
                    decryptor?.add(data as Data!)
                    //println("Sent \(bytesRead) bytes to decryptor.")
                }
                else{
                    print("Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.")
                    if let completion = completionHandler{
                        completion(writeBuffer as Data)
                    }
                }
            }
            
            decryptor = RNCryptorHelper.decryptor(withKey: key, handler: { (xcryptor, xdata) in
                //println("Encryptor received \(data.length) bytes.")
                guard let cryptor = xcryptor else{
                    fatalError("")
                }
                guard let data = xdata else{
                    fatalError("")
                }
                let buffer = NSData(data: data).bytes.bindMemory(to: UInt8.self, capacity: data.count)
                writeBuffer.append(buffer, length: data.count)
                if cryptor.isFinished{
                    if let completion = completionHandler{
                        completion(writeBuffer as Data)
                    }
                }
                else{
                    self.calculateProgress(totalReadWrite: totalWritenLength, totalDataLength: self.sizeInBytes, progress: progress)
                    readStreamBlock()
                }
            })
            
            readStreamBlock()
        })
    }
    
    open func decrypt(to file: IFile, bufferSize bSize: Int, password key: String, progress: IFileProgress?, completionHandler: ((Bool) -> Void)? = nil){
        //Following Code is copied from https://github.com/RNCryptor/RNCryptor#async-and-streams
        //As Suggested by RNCrypto framework auther -> How to use encryption/decryption with RNCrypto API.
        //Actual code was written in Objective-C. Here we have converted into Swift.
        //Please, feel free to Copy/Modify folloing lines of code. RNCrypto API is MIT License.
        DispatchQueue.global().async(execute: { () -> Void in
            var bufferSize = bSize
            if bSize < 1024{
                bufferSize = 1024
            }
            let blockSize = 2 * bufferSize
            let readStream: InputStream = InputStream(fileAtPath: self.URL.path)!
            let writeStream: OutputStream = OutputStream(toFileAtPath: file.URL.path, append: false)!
            
            readStream.open()
            writeStream.open()
            
            var data = Data(count: blockSize)
            var decryptor: RNDecryptor? = nil
            var totalWritenLength: Int = 0
            let readFileTotalBytes = self.sizeInBytes
            
            let readStreamBlock: ()->() = { (Void) -> Void in
                
                let buffer = data.withUnsafeMutableBytes({ (ptr: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> in
                    return ptr
                })
                let bytesRead = readStream.read(buffer, maxLength: blockSize)
                if bytesRead == 0{
                    readStream.close()
                    decryptor?.finish()
                }
                else if bytesRead > 0{
                    totalWritenLength += bytesRead
                    data.count = bytesRead
                    decryptor?.add(data as Data!)
                    //println("Sent \(bytesRead) bytes to encryptor.")
                }
                else{
                    print("Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.")
                    if let completion = completionHandler{
                        completion(false)
                    }
                }
            }
            
            decryptor = RNCryptorHelper.decryptor(withKey: key, handler: { (xcryptor: RNCryptor?, xdata: Data?) -> Void in
                guard let cryptor = xcryptor else{
                    fatalError("")
                }
                guard let data = xdata else{
                    fatalError("")
                }
                //println("Encryptor received \(data.length) bytes.")
                let buffer = NSData(data: data).bytes.bindMemory(to: UInt8.self, capacity: data.count)
                writeStream.write(buffer, maxLength: data.count)
                if cryptor.isFinished{
                    writeStream.close()
                    if let completion = completionHandler{
                        completion(true)
                    }
                }
                else{
                    self.calculateProgress(totalReadWrite: totalWritenLength, totalDataLength: readFileTotalBytes, progress: progress)
                    readStreamBlock()
                }
            })
            
            readStreamBlock()
        })
    }
    
    open func secureWrite(from readfile: IFile, bufferSize bSize: Int = 1024, password key: String, progress: IFileProgress? = nil, completionHandler: ((Bool)->Void)? = nil){
        //Following Code is copied from https://github.com/RNCryptor/RNCryptor#async-and-streams
        //As Suggested by RNCrypto framework auther -> How to use encryption/decryption with RNCrypto API.
        //Actual code was written in Objective-C. Here we have converted into Swift.
        //Please, feel free to Copy/Modify folloing lines of code. RNCrypto API is MIT License.
        DispatchQueue.global().async(execute: { () -> Void in
            //
            if (self.fileExist()){
                let _ = self.delete()
            }
            var bufferSize = bSize
            if bSize < 1024{
                bufferSize = 1024
            }
            let blockSize = 2 * bufferSize
            let readStream: InputStream = InputStream(fileAtPath: readfile.URL.path)!
            let writeStream: OutputStream = OutputStream(toFileAtPath: self.URL.path, append: false)!
            
            readStream.open()
            writeStream.open()
            
            var data = Data(count: blockSize)
            var encryptor: RNEncryptor? = nil
            var totalWritenLength: Int = 0
            let readFileTotalBytes = readfile.sizeInBytes
            
            let readStreamBlock: ()->() = { (Void) -> Void in
                
                let buffer = data.withUnsafeMutableBytes({ (ptr: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> in
                    return ptr
                })
                let bytesRead = readStream.read(buffer, maxLength: blockSize)
                if bytesRead == 0{
                    readStream.close()
                    encryptor?.finish()
                }
                else if bytesRead > 0{
                    totalWritenLength += bytesRead
                    data.count = bytesRead
                    encryptor?.add(data as Data!)
                    //println("Sent \(bytesRead) bytes to encryptor.")
                }
                else{
                    print("Error Has Occoured In DNFile.secureWrite(from:bufferSize:password:completionHandler:) method.")
                    if let completion = completionHandler{
                        completion(false)
                    }
                }
            }
            
            encryptor = RNCryptorHelper.encryptor(withKey: key, handler: { (xcryptor, xdata) in
                guard let cryptor = xcryptor else{
                    fatalError("")
                }
                guard let data = xdata else{
                    fatalError("")
                }
                //println("Encryptor received \(data.length) bytes.")
                let buffer = NSData(data: data).bytes.bindMemory(to: UInt8.self, capacity: data.count)
                writeStream.write(buffer, maxLength: data.count)
                if cryptor.isFinished{
                    writeStream.close()
                    if let completion = completionHandler{
                        completion(true)
                    }
                }
                else{
                    self.calculateProgress(totalReadWrite: totalWritenLength, totalDataLength: readFileTotalBytes, progress: progress)
                    readStreamBlock()
                }
            })
            
            readStreamBlock()
        })
        
    }
    
}
