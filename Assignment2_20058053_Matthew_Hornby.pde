    import javax.swing.*;

    //Objects required in the program
    Player p;                           //Manage player, animations, hit
    Game g;                             //Load Game, load assets, detect collisions between objects
    Loader l;                           //Load assets
    Level level;                        //Manage background, draw level, manage screenborders
    Enemy[] enemy;                      //Manage melee enemy, animations, hit, onHit
    EnemyRanged[] enemyRanged;          //Manage ranged enemy, animations, hit, onHit
    Bullet[] bullet;                    //Manage bullet, where it fires from, kills bullet

    //Image arrays
    PImage[] playerImages;
    PImage[] enemyImages;
    PImage[] levelImages;
    PImage[] bulletImages;

    //game variables
    private int difficulty;
    private int maxNumberGames;
    private int maxNumberEnemies;
    private int maxNumberMeleeEnemies;
    private String userName;

    void setup() {
        size(800, 600);
        background(255);
        
        //Begin Game
        greeting();
        determineDifficultyInputValidity(userName);
        determineMaxGames(userName);
        determineMaxEnemies(userName);
        maxNumberMeleeEnemies = maxNumberEnemies / 2;
        if (maxNumberMeleeEnemies <=  1) {
            maxNumberMeleeEnemies = 1;
        }
        
        
        g = new Game(difficulty, maxNumberGames, maxNumberEnemies,  maxNumberMeleeEnemies);
        
        //create Loader Object
        l = new Loader();
        
        //create Level Object
        level = new Level();
        levelImages = l.loadSpritesheets("level", level);
        level.setImageArray(levelImages);
        
        //create Player Object
        p = new Player(userName, difficulty);
        playerImages = l.loadSpritesheets("player", p);
        p.setImageArray(playerImages);
        
        //create Enemy Object
        enemy = new Enemy[maxNumberMeleeEnemies];
        for (int i = 0;i < maxNumberMeleeEnemies; i++) {
            enemy[i] = new Enemy(difficulty);
            enemyImages = l.loadSpritesheets("enemy", enemy[i]);
            enemy[i].setImageArray(enemyImages);
        }
        
        //create Ranged Enemy Object
        enemyRanged = new EnemyRanged[maxNumberEnemies];
        bullet = new Bullet[maxNumberEnemies];
        
        for (int i = 0;i < maxNumberEnemies; i++) {
            bullet[i] = new Bullet(i);
            bulletImages = l.loadSpritesheets("bullet", bullet[i]);
            bullet[i].setImageArray(bulletImages);
            enemyRanged[i] = new EnemyRanged(difficulty, i);
            enemyImages = l.loadSpritesheets("player", p);
            enemyRanged[i].setImageArray(enemyImages);
        }
        
        //setup complete messages
        setupComplete();
    }

    void draw() {
        background(0,0,0);
        //update game - check for collisions, update score, spawn enemies
        g.updateGame();
        
        if (g.getNumberGamesPlayed() == maxNumberGames) {
            gameOver();
        }
        
        if (g.getLivesLost() == g.getMaximumLives()) {
            g.newGame();
        }
        
        
        else{
            g.updateGame();
            
            //update Level - draw level background
            level.update();
            
            //update Player - update player location, draw player, update animations
            p.setHitBoxColour(0,0,255,50);
            p.update();
            p.getPlayerDeath();
            
            //update Enemy - update enemy location, draw enemy, update animations
            for (int i = 0;i < maxNumberMeleeEnemies; i++) {
                if (enemy[i].getDeath() == false) {
                    enemy[i].update();
                }
                
            }
            
            //update Enemy Ranged - update enemy location, draw enemy, update animations
            for (int i = 0;i < maxNumberEnemies; i++) {
                if (enemyRanged[i].getDeath() == false) {
                    enemyRanged[i].update();
                    bullet[i].update();
                }
            }
            drawScore();
        }
        
    }

    private void drawScore() {
        int displayHealth;
        displayHealth = p.getPlayerMaxHealth()-p.getDamageTaken();
        if (displayHealth<0){
            displayHealth = 0;
        }
        stroke(255,255,255);
        fill(255, 255, 255);
        text("SCORE: " + g.getScore(),width - 100,level.getletterBoxSize() / 2);
        text("LIVES REMAINING: " + g.getLivesLeft(),100,level.getletterBoxSize() / 2);
        text("HEALTH: " + displayHealth,100,height-level.getletterBoxSize() / 2);
        noStroke();
    }   



    private void greeting() {
        userName = JOptionPane.showInputDialog("Hello, what is your name?");
        if (userName == null || userName.length() == 0) {
            userName = "UserName";
        }
        userName = userName.replaceAll("\\s", "");
    }
    private void determineMaxGames(String userName) {
        maxNumberGames = Integer.parseInt(JOptionPane.showInputDialog(userName + ", please choose how many games you would like to play"));
    }

    private void determineMaxEnemies(String userName) {
        maxNumberEnemies = Integer.parseInt(JOptionPane.showInputDialog(userName + ", please choose how many Enemeies you would like to challenge"));
    }

    private void determineDifficultyInputValidity(String usersName) {
        String input = JOptionPane.showInputDialog(usersName + ", please select how difficult you would like the game to be - Easy, Medium or Hard?");
        if (input == null) {
            determineDifficultyInputValidity(userName);
        }
        input = input.toUpperCase();
        if (input.equals("EASY") || input.equals("MEDIUM") || input.equals("HARD")) {
            determineDifficulty(input);
            } else {
            JOptionPane.showMessageDialog(null, "Invalid Input, please try again");
            println("input is: ", input);
            determineDifficultyInputValidity(userName);
            }
        }

    private void determineDifficulty(String input) {
        println("difficulty is: ", difficulty);
        if (input.equals("EASY")) {
            difficulty = 1;
            } else if (input.equals("MEDIUM")) {
            difficulty = 2;
            } else if (input.equals("HARD")) {
            difficulty = 3;
            }
        }

    private void setupComplete() {
        JOptionPane.showMessageDialog(null, "Game State: " +
            "\n Username: " + userName +
            "\n Number of Games to Play: " + maxNumberGames +
            "\n Lives: " + g.getMaximumLives() +
            "\n Difficulty: " + difficulty +
            "\n Max Ranged Enemies: " + maxNumberEnemies +
            "\n Max Melee Enemies: " + maxNumberMeleeEnemies +
            "\n Player health: " + p.getPlayerMaxHealth() +
            "\n Player Damage: " + p.getAttackDamage() +
            "\n Enemy Health: " + enemy[0].getEnemyHealth() +
            "\n Enemy Damage: " + enemy[0].getEnemyAttackDamage() +
            "\n Enemy Ranged health: " + enemyRanged[0].getEnemyRHealth() +
            "\n Enemy Ranged Damage: " + enemyRanged[0].getEnemyAttackDamage() +
            "\n Enemy Ranged Attack Range: " + enemyRanged[0].getEnemyRAttackRange());
        }

    private void gameOver() {
        int yesNo;
        println("Game over:");
        
        yesNo = JOptionPane.showConfirmDialog(null,"Would you like to play again?");
        if (yesNo == JOptionPane.YES_OPTION) {
            newTournament();
            }
        else{
            sessionOver();
            exit();
            }
        }

    private void newTournament() {
        maxNumberGames = maxNumberGames + maxNumberGames;
        g.setCount(0);
        g.newGame();
        }

    private void sessionOver() {
        JOptionPane.showMessageDialog(null, p.getPlayerName() + ", your session is over! \n\n"  
            + "\nNumber of games played: " + g.getNumberGamesPlayed()
            + "\nNumber of games won: "    + g.getNumberGamesWon()
            + "\n\n"                     + g.getGameToString()
            + "\n\nHighest Score: "      + g.getHighestScore()
            +   "\nLowest Score:  "      + g.getLowestScore()
            +   "\nAverage Score: "      + g.getAverageScore());
        exit();     
        }


    // Controls
    void keyPressed() {
        p.playerControls(keyPressed);
        }

    void keyReleased() {
        p.playerControls();
        }
