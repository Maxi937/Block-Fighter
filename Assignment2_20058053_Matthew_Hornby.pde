import javax.swing.*;

//Objects required in the program
Player p;                           //Manage player, animations, hit
Game g;                             //Load Game, load assets, detect collisions between objects
Loader l;                           //Load assets
Level level;                        //Manage background, draw level, manage screenborders
Enemy enemy;                        //Manage melee enemy, animations, hit, onHit
EnemyRanged enemyRanged;            //Manage ranged enemy, animations, hit, onHit
Bullet bullet;                      //Manage bullet, where it fires from, kills bullet

//Image arrays
PImage[] playerImages;
PImage[] enemyImages;
PImage[] levelImages;
PImage[] bulletImages;

//game variables
private int difficulty;
private int maxNumberGames;
private String userName;

void setup() {
    size(800, 600);
    background(255);
    
    //Begin Game
    greeting();
    determineDifficultyInputValidity(userName);
    determineMaxGames(userName);


    g = new Game(difficulty, maxNumberGames);
    
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
    enemy = new Enemy(difficulty);
    enemyImages = l.loadSpritesheets("enemy", enemy);
    enemy.setImageArray(enemyImages);
    
    //create Ranged Enemy Object
    enemyRanged = new EnemyRanged(difficulty);
    enemyImages = l.loadSpritesheets("player", p);
    enemyRanged.setImageArray(enemyImages);
    
    //create Bullet Object
    bullet = new Bullet();
    bulletImages = l.loadSpritesheets("bullet", bullet);
    bullet.setImageArray(bulletImages);
    
    //setup complete messages
    setupComplete();
}

void draw() {
    background(0,0,0);
    //update game - check for collisions, update score, spawn enemies
    g.updateGame();

    if (g.getNumberGamesPlayed() == maxNumberGames){
        gameOver();
    }

    if (g.getLivesLost() == g.getMaximumLives()){
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
        enemy.setHitBoxColour(255,0,0,50);
        enemy.update();
        g.getHit(p, enemy);
        g.getHit(enemy, p);
        
        //update Enemy Ranged - update enemy location, draw enemy, update animations
        enemyRanged.setHitBoxColour(255,0,0,50);
        enemyRanged.update();
        g.getHit(p, enemyRanged);
        g.getHit(bullet, p, enemyRanged);
        
        //update bullet object - update bullet location, kill bullet
        bullet.update(); 

        drawScore();
    }
    
}

private void drawScore(){
    stroke(255,255,255);
    fill(255, 255, 255);
    text("SCORE: " + g.getScore(),width-100,level.getletterBoxSize()/2);
    text("LIVES REMAINING: " + g.getLivesLeft(),100,level.getletterBoxSize()/2);
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
        "\n Player health: " + p.getPlayerHealth() +
        "\n Player Damage: " + p.getAttackDamage() +
        "\n Enemy Health: " + enemy.getEnemyHealth() +
        "\n Enemy Damage: " + enemy.getEnemyAttackDamage() +
        "\n Enemy Ranged health: " + enemyRanged.getEnemyRHealth() +
        "\n Enemy Ranged Damage: " + enemyRanged.getEnemyAttackDamage() +
        "\n Enemy Ranged Attack Range: " + enemyRanged.getEnemyRAttackRange());
}

private void gameOver() {
        int yesNo;
        println("Game over:");
    
        yesNo = JOptionPane.showConfirmDialog(null,"Would you like to play again?");
            if(yesNo == JOptionPane.YES_OPTION){
                newTournament();
            }
            else {
                sessionOver();
            }
    }

private void newTournament() {
       maxNumberGames = maxNumberGames + maxNumberGames;

    }

private void sessionOver() {
      JOptionPane.showMessageDialog(null, p.getPlayerName() + ", your session is over! \n\n"  
                                 + "Number of games played: " + g.getNumberGamesPlayed()
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
