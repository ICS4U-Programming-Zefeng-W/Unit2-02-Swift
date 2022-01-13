/*
  RecursiveFactorial.swift
  
  By Zefeng Wang
  Created on January 12, 2022
  
  This program uses a recursive function to get the factorial of each number in input.txt
  and outputs it to output.txt
*/

// Import the Foundation module 
import Foundation

// Recursive function to take the factorial of a number
func factorial(num: Int) -> Int {
	if num == 0 || num == 1 {
		return 1
	} else {
		return num &* factorial(num: num - 1)
	}
}

// Reads information from input.txt
let contents = try String(contentsOfFile: "input.txt")
let numArr = contents.components(separatedBy: "\n").filter { $0 != "" }.map { Int($0) }

// Clears the file
let text = ""
do {
        try text.write(to: URL(fileURLWithPath: "output.txt"), atomically: false,
                                                encoding: .utf8)
} catch {
        print(error)
}

// Display the answer to output.txt as well as error messages
if let fileWriter = try? FileHandle(forUpdating: URL(fileURLWithPath: "output.txt")) {
	if numArr.count == 0 {
		fileWriter.write(("Please enter at least one number to input.txt").data(using: .utf8)!)
	} else {
		for number in numArr {
			if let num = number, !(num < 0) {
				if factorial(num: num) <= 0 {
                        		fileWriter.seekToEndOfFile()
                        		fileWriter.write(("Please enter a smaller number" + "\n").data(using: .utf8)!)
                        	} else {
                        		fileWriter.seekToEndOfFile()
                        		fileWriter.write((String(factorial(num: num)) + "\n").data(using: .utf8)!)
                        	}
			} else {
				fileWriter.seekToEndOfFile()
				fileWriter.write(("Please enter a non-negative number" + "\n").data(using: .utf8)!)
			}
		}
		fileWriter.closeFile()
	}
}
