class Game {
    
//---PROPERTIES---//

    //game variables
    private int score;
    private int difficulty;
    private int maximumLives;
    private String name;

    //collision
    float collisionTarget;
    float collisionDistance;


//---CONSTRUCTOR---//

    Game() {
        score = 0;
        maximumLives = 0;
        this.difficulty = difficulty;

    }
    
//---METHODS---//
    private void updateGame() {
        getHit(bullet, p);
        getHit(p, enemy);
        getHit(p, enemyRanged);
        getHit(enemy, p);
    }

    //getters
    private void getHit(Bullet b, Player p) {
        if (b.getShooting() == true) {
            collisionTarget = p.getPlayerXPos();
            collisionDistance = b.getBulletXPos() - collisionTarget;
            if (collisionDistance < 5 && collisionDistance > - 5) {
                //print("/nI am pasing the player");
                if (b.getBulletYPos() == p.getPlayerYPos() && p.getBlocking() == false) {
                    //print("\nI have hit the player");
                    p.setHit();
                    bullet.setHit();
                }
                else {
                    //print("\nI have missed");
                    bullet.setMiss();
                    g.setScore(20);
                } 
            }
        }     
    }
    
    private void getHit(Player player, Enemy e) {
        
        if (player.getPlayerAttacking()) {
            collisionTarget = e.getEnemyXPos();
            collisionDistance = abs(player.getPlayerXPos() - collisionTarget);
            //print("\nTarget: ", collisionTarget);
            //print("\nDX: ", collisionDistance);
            //print("\nattackbox: ", player.getPlayerAttackBoxW());
            if (collisionDistance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getDirection() != e.getDirection()) {
                    e.setHit(player.getAttackDamage());
                    print("\nI have hit an enemy");
                    g.setScore(2);
                }
                
            }
            
        }
    }

    private void getHit(Player player, EnemyRanged e) {
        
        if (player.getPlayerAttacking()) {
            collisionTarget = e.getEnemyXPos();
            collisionDistance = abs(player.getPlayerXPos() - collisionTarget);
            //print("\nTarget: ", target);
            //print("\nDX: ", distance);
            //print("\nattackbox: ", player.getPlayerAttackBoxW());
            if (collisionDistance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getDirection() != e.getDirection()) {
                    e.setHit(player.getAttackDamage());
                   //print("\nI have hit an enemy");
                }
                
            }
            
        }
    }

    private void getHit(Enemy e ,Player player) {
        
        if (e.getEnemyAttacking()) {
            collisionTarget = player.getPlayerXPos();
            collisionDistance = abs(e.getEnemyXPos() - collisionTarget);
            //print("\nTarget: ", collisionTarget);
            //print("\nDX: ", collisionDistance);
            //print("\nattackbox: ", player.getPlayerAttackBoxW());
            if (collisionDistance < e.getEnemyAttackBoxW() + e.getEnemyHitBoxW()+2) {
                if (e.getDirection() != player.getDirection() && p.getBlocking() == false) {
                    player.setHit();
                    e.setOnHit();
                   print("\nI have hit");
                }
                if (p.getBlocking()) {
                    e.setOnHit();
                   //print("\nI have hit an enemy");
                }
                
            }
            
        }
    }

    public int getScore(){
        return score;
    }

    //setters
    public void setScore(int s){
        score = score + s;
    }
}
    
