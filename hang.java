import java.util.Scanner;

public class hang {

    private static final String[] WORDS = {"apple", "banana", "orange", "pear", "kiwi", "grape"};
    private static final int MAX_TRIES = 6;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String word = WORDS[(int) (Math.random() * WORDS.length)];
        StringBuilder hidden = new StringBuilder(word.length());
        for (int i = 0; i < word.length(); i++) {
            hidden.append("_");
        }

        int tries = 0;
        while (tries < MAX_TRIES && hidden.toString().contains("_")) {
            System.out.println("Guess a letter:");
            char guess = scanner.nextLine().charAt(0);

            boolean found = false;
            for (int i = 0; i < word.length(); i++) {
                if (word.charAt(i) == guess) {
                    hidden.setCharAt(i, guess);
                    found = true;
                }
            }

            if (found) {
                System.out.println("Correct!");
            } else {
                System.out.println("Incorrect. You have " + (MAX_TRIES - tries - 1) + " tries left.");
                tries++;
            }

            System.out.println(hidden.toString());
        }

        if (!hidden.toString().contains("_")) {
            System.out.println("Congratulations, you won!");
        } else {
            System.out.println("Sorry, you lost. The word was: " + word);
        }
    }
}
