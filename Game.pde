class Game {
    
    //---PROPERTIES---//
    
    //collision
    private float collisionTarget;
    private float collisionDistance;
    
    //score variables
    private int missScore;
    private int blockScore;
    private int hitScore;
    private int scoreBoardSize;
    private int score;
    private int[] scores;
    private int count;
    
    //Game
    private int maximumLives;
    private int livesLost;
    private int gamesPlayed;
    
    //---CONSTRUCTOR---//
    
    Game(int difficulty, int maxNumberGames) {
        missScore = 10 * difficulty;
        blockScore = 2 * difficulty;
        hitScore = 5 * difficulty;
        maximumLives = 6 / difficulty;
        scores = new int [maxNumberGames];
    }
    
    //---METHODS---//
    private void updateGame() {
        getHit(bullet, p, enemyRanged);
        getHit(p, enemy);
        getHit(p, enemyRanged);
        getHit(enemy, p);
        loseaLife();
    }

    public void addScore(int score)
    {
        if (score >= 0) {
            scores[count] = score;
            count++;
        }
  } 
    
    private void loseaLife() {
        if (p.getPlayerDeath() == true) {
            println("get pleayer death: ", p.getPlayerDeath());
            p.setPlayerDeath(false);
            livesLost = livesLost + 1;
            println("lives lost: ",livesLost); 
            p.setDamageTaken(0);
            p.setPlayerXpos(50);  
        }
        if (livesLost >= maximumLives){
            addScore(score);
        }
    }
    
    //getters
    private void getHit(Bullet b, Player p, EnemyRanged er) {
        if (b.getShooting() == true) {
            collisionTarget = p.getPlayerXPos();
            collisionDistance = b.getBulletXPos() - collisionTarget;
            if (collisionDistance < 5 && collisionDistance > - 5) {
                //print("/nI am pasing the player");
                if (b.getBulletYPos() == p.getPlayerYPos() && p.getBlocking() == false) {
                    println("\nPLayer Hit: ", er.getEnemyAttackDamage(), " Damage Done");
                    p.setHit(er.getEnemyAttackDamage());
                    bullet.setHit();
                }
                else{
                    //print("\nI have missed");
                    bullet.setMiss();
                    g.setScore(missScore);
                } 
            }
        }   
    }
    
    private void getHit(Player player, Enemy e) {
        
        if (player.getPlayerAttacking()) {
            collisionTarget = e.getEnemyXPos();
            collisionDistance = abs(player.getPlayerXPos() - collisionTarget);
            if (collisionDistance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getDirection() != e.getDirection()) {
                    e.setHit(player.getAttackDamage());
                    g.setScore(hitScore/10);
                }
                
            }
            
        }
    }
    
    private void getHit(Player player, EnemyRanged er) {
        
        if (player.getPlayerAttacking()) {
            collisionTarget = er.getEnemyXPos();
            collisionDistance = abs(player.getPlayerXPos() - collisionTarget);
            if (collisionDistance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getDirection() != er.getDirection()) {
                    er.setHit(player.getAttackDamage());
                    g.setScore(hitScore/10);
                }
                
            }
            
        }
    }
    
    private void getHit(Enemy e ,Player player) {
        
        if (e.getEnemyAttacking()) {
            collisionTarget = player.getPlayerXPos();
            collisionDistance = abs(e.getEnemyXPos() - collisionTarget);
            if (collisionDistance < e.getEnemyAttackBoxW() + e.getEnemyHitBoxW() + 2) {
                if (e.getDirection() != player.getDirection() && p.getBlocking() == false) {
                    player.setHit(e.getEnemyAttackDamage());
                    e.setOnHit();
                }
                if (p.getBlocking()) {
                    e.setOnHit();
                    g.setScore(blockScore/10);
                    
                }
                
            }
            
        }
    }
    
    public int getScore() {
        return score;
    }
    
    public int getScoreBoardSize() {
        return scoreBoardSize;
    }
    
    public int getMaximumLives() {
        return maximumLives;
    }
    
    public int getLivesLost() {
        return livesLost;
    }
    
    public int getLivesLeft() {
        return maximumLives - livesLost;
    }

    private int getNumberGamesPlayed(){
        return gamesPlayed;
    }
    
    public void getInstructions() {
        JOptionPane.showMessageDialog(null, "Controls: " +
            "\n Use 'a' to move left" +
            "\n Use 'd' to move right" +
            "\n Use 'q' to block" +
            "\n Use 'e' to attack"+
            "\n Use 'space' to jump");
    }   

    public String getGameToString() {
        String str = "Scores for " + p.getPlayerName() + "\n";
        for (int i = 0; i < count; i++) {
            str = str + "     Game " + (i+1) + ": " + scores[i] + "\n";
        }   
        return str;
    }

    public int getHighestScore() {
        int highestScore = scores[0];
        for (int i = 1; i < count; i++) {
        if (scores[i] > highestScore) {
         highestScore = scores[i];
      }
    }   
    return highestScore;
    }


    public int getLowestScore() {
        int lowestScore = scores[0] ;
        for (int i = 1; i < count; i++) {
        if (scores[i] < lowestScore) {
        lowestScore = scores[i];
      }
    }   
    return lowestScore;
    }

    public int getAverageScore() {
        int total = 0;
        for (int i = 0; i < count; i++) {
            total = total + scores[i];
        }   
    return total / count;
    }
    
    
    //setters
    public void setScore(int s) {
        score = score + s;
    }
    
    public void setLivesLost(int numberOfLivesLost) {
        livesLost = numberOfLivesLost;
    }

    private void newGame() { 
        score = 0;
        livesLost = 0;
        gamesPlayed = gamesPlayed + 1;
        p.setPlayerXpos(50);
    }

    
}
