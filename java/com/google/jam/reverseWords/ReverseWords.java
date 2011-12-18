package com.google.jam.reverseWords;

import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedList;

public class ReverseWords {

  
  
  public ReverseWords(String fileName) throws Exception {
    InputStream stream = getStream(fileName);
    runWithStream(stream);
  }
  
  
  private void runWithStream(InputStream stream) throws Exception {
    long currentCase = 1;
    LinkedList<String> currentLine = new LinkedList<String>(); 
    StringBuilder currentWord = new StringBuilder();
    
    // Read the number of cases (and ignore the return)
    readNumCases(stream); 
    
    // 
    int c;
    while ((c = stream.read()) != -1) {
      char currentChar = (char) c;
      
      if (Character.isLetter(currentChar)) {
        currentWord.append(currentChar);
      }
      else if (Character.isSpaceChar(currentChar) || 
               isNewline(currentChar)) {
        currentLine.add(currentWord.toString());
        currentWord = new StringBuilder();
      }
      
      if (isNewline(currentChar)) {
        Iterator<String> iterator = currentLine.descendingIterator();
        
        if (currentCase > 1)
          System.out.print('\n');
        
        System.out.print("Case #" + currentCase + ":");
        while (iterator.hasNext()) {
          System.out.print(' ');
          System.out.print(iterator.next());
        }
        
        currentCase++;
        currentLine = new LinkedList<String>();
      }
    }
  }

  private final boolean isNewline(char c) {
    return c == '\n';
  }

  private long readNumCases(InputStream stream) throws Exception {
    StringBuilder sb = new StringBuilder();
    char chr;
    
    while ((chr = (char) stream.read()) != '\n') {
      sb.append(chr);
    }
    
    return Long.parseLong(sb.toString());
  }


  private InputStream getStream(String fileName) {    
    return ReverseWords.class.getResourceAsStream(fileName);
  }
  

  /**
   * @param args
   */
  public static void main(String[] args) throws Exception {
    new ReverseWords("B-small-practice.in");
  }
}
