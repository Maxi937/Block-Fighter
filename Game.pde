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
    private int enemiesKilled;
    
    //Game
    private int maximumLives;
    private int maxNumberEnemies;
    private int maxNumberMeleeEnemies;
    private int totalMaxEnemies;
    private int livesLost;
    private int gamesPlayed;
    private int gamesWon;
    
    //---CONSTRUCTOR---//
    
    Game(int difficulty, int maxNumberGames, int maxNumberEnemies, int maxNumberMeleeEnemies) {
        missScore = 10 * difficulty;
        blockScore = 2 * difficulty;
        hitScore = 5 * difficulty;
        maximumLives = 6 / difficulty;
        this.maxNumberEnemies = maxNumberEnemies;
        this.maxNumberMeleeEnemies = maxNumberMeleeEnemies;
        totalMaxEnemies = maxNumberEnemies + maxNumberMeleeEnemies;
        scores = new int[maxNumberGames];
    }
    
    //---METHODS---//
    private void updateGame() {
        
        for (int i = 0;i < maxNumberMeleeEnemies; i++) {
            if (enemy[i].getDeath() == false) {
                getHit(p, enemy[i]);
                getHit(enemy[i], p);
                getEnemyDeath(enemy[i]);
            }
        }
        
        for (int i = 0;i < maxNumberEnemies; i++) {
            if (enemyRanged[i].getDeath() == false) {
                getHit(bullet[i], p, enemyRanged[i]);
                getHit(p, enemyRanged[i]);
                getEnemyDeath(enemyRanged[i]);
            }
        }
        loseaLife();
        if (enemiesKilled >= totalMaxEnemies) {
            wonGame();
        }
        
    }
    
    private void loseaLife() {
        if (p.getPlayerDeath() == true) {
            p.setPlayerDeath(false);
            livesLost = livesLost + 1;
            p.setDamageTaken(0);
            p.setPlayerXpos(50); 
            for (int i = 0;i < maxNumberEnemies;i++) {
                resetBullets(bullet[i]);
        }
            
        }
        if (livesLost >= maximumLives) {
            addScore(score);
        }
    }
    
    public void addScore(int score) {
        if (score >= 0) {
            scores[count] = score;
            count++;
        }
    } 
    
    private void newGame() {
        score = 0;
        livesLost = 0;
        gamesPlayed = gamesPlayed + 1;
        p.setPlayerXpos(50);
        for (int i = 0;i < maxNumberEnemies;i++) {
            resetEnemies(enemyRanged[i]);
        }
        for (int i = 0;i < maxNumberMeleeEnemies;i++) {
            resetEnemies(enemy[i]);
        }
        enemiesKilled = 0;
        
    }
    
    private void wonGame() { 
        score = score + (score * difficulty);
        addScore(score);
        score = 0;
        livesLost = 0;
        gamesWon = gamesWon + 1;
        gamesPlayed = gamesPlayed + 1;
        p.setPlayerXpos(50);
        for (int i = 0;i < maxNumberEnemies;i++) {
            resetEnemies(enemyRanged[i]);
        }
        for (int i = 0;i < maxNumberMeleeEnemies;i++) {
            resetEnemies(enemy[i]);
        }
        
        enemiesKilled = 0;
    }
    private void resetBullets(Bullet b) { 
            b.setBulletXPos(-10,0,false);
        }

    private void resetEnemies(EnemyRanged er) { 
        for (int i = 0;i < maxNumberEnemies;i++) {
            er.setDeath(false);
            er.setXPos(850 + random(0,30));
            er.setDamageTaken(0);
        }
    }
    
    private void resetEnemies(Enemy e) { 
        for (int i = 0;i < maxNumberEnemies;i++) {
            e.setDeath(false);
            e.setXPos(850 + random(0,30));
            e.setDamageTaken(0);
        }
    }
    
    //getters
    private void getHit(Bullet b, Player player, EnemyRanged er) {
        if (b.getShooting() == true) {
            collisionTarget = p.getPlayerXPos();
            collisionDistance = b.getBulletXPos() - collisionTarget;
            if (collisionDistance < 5 && collisionDistance > - 5) {
                if (b.getBulletYPos() == p.getPlayerYPos() && p.getBlocking() == false) {
                    player.setHit(er.getEnemyAttackDamage());
                    b.setHit();
                }
                else{
                    
                    b.setMiss();
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
                if (player.getPlayerXPos() > e.getEnemyXPos() && player.getDirection() ==  false) {
                    e.setHit(player.getAttackDamage());
                }
                if (player.getPlayerXPos() < e.getEnemyXPos() && player.getDirection() ==  true) {
                    e.setHit(player.getAttackDamage());
                } 
            }
            
        }
    }
    
    private void getHit(Player player, EnemyRanged er) {
        
        if (player.getPlayerAttacking()) {
            collisionTarget = er.getEnemyXPos();
            collisionDistance = abs(player.getPlayerXPos() - collisionTarget);
            if (collisionDistance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getPlayerXPos() > er.getEnemyXPos() && player.getDirection() ==  false) {
                    er.setHit(player.getAttackDamage());
                }
                if (player.getPlayerXPos() < er.getEnemyXPos() && player.getDirection() ==  true) {
                    er.setHit(player.getAttackDamage());
                }  
            }
            
        }
    }
    
    private void getHit(Enemy e ,Player player) {
        
        if (e.getEnemyAttacking()) {
            collisionTarget = player.getPlayerXPos();
            collisionDistance = abs(e.getEnemyXPos() - collisionTarget);
            if (collisionDistance < e.getEnemyAttackBoxW() + e.getEnemyHitBoxW() + 2) {
                 if (player.getPlayerXPos() > e.getEnemyXPos() && e.getDirection() ==  true && p.getBlocking() == false) {
                    player.setHit(e.getEnemyAttackDamage());
                    e.setOnHit();
                }
                if (player.getPlayerXPos() < e.getEnemyXPos() && e.getDirection() ==  false && p.getBlocking() == false) {
                    player.setHit(e.getEnemyAttackDamage());
                    e.setOnHit();
                }
                if (p.getBlocking()) {
                    e.setOnHit();
                    g.setScore(blockScore / 10);
                    
                }
                
            }
            
        }
    }
    
    
    private void getEnemyDeath(Enemy e) {
        if (e.getKillEvent()) {
            e.setkillEvent(false);
            enemiesKilled = enemiesKilled + 1;
            score = score + (50 * difficulty);         
        }
    }
    
    private void getEnemyDeath(EnemyRanged er) {
        if (er.getKillEvent()) {
            er.setKillEvent(false);
            enemiesKilled = enemiesKilled + 1;
            score = score + (30 * difficulty);   
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
    
    public int getNumberGamesPlayed() {
        return gamesPlayed;
    }
    
    public int getNumberGamesWon() {
        return gamesWon;
    }
    
    public String getGameToString() {
        String str = "Scores for " + p.getPlayerName() + "\n";
        for (int i = 0; i < count; i++) {
            str = str + "     Game " + (i + 1) + ": " + scores[i] + "\n";
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
        int lowestScore = scores[0];
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
    
    public void setCount(int count) {
        this.count = count;
    }
    
}
