// Auxiliary material for PI2 lecture, University of Mannheim
//
// Run with: javac Rice.java && java Rice
//
// Author: Rainer Gemulla
public class Rice {
  public static void main(String[] args) {
    long grains = 0;             // total number of grain on board

    long next = 1;               // grains placed on next square
    for (int i = 0; i<64; i++) {
      grains += next;
      next *= 2;
    }
    System.out.println("There are " + grains + " rice grains on the chessboard.");
    System.out.println("After adding one more rice grain, there are "
                       + (grains+1) + " rice grains on the chessboard.");
  }
}
