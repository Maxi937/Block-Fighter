public class CollisionDetector {
    
    //---PROPERTIES---//
    float target;
    float distance;
    
    
    
    //---CONSTRUCTOR---//
    CollisionDetector() {
        
    }
    
    //- --Methods---//
    public void update() {
        //print("\n player Xpos: ",p.getPlayerXPos());
        //print("\n bullet Xpos: ",bullet.getBulletXPos());
        //print("\n player Ypos: ",p.getPlayerYPos());
        //print("\n bullet Ypos: ",bullet.getBulletYPos());
        
        //print("\ndx: ",distance);
        
    }
    
    //getters
    private void getHit(Bullet b, Player p) {
        if (b.getShooting() == true) {
            target = p.getPlayerXPos();
            distance = b.getBulletXPos() - target;
            if (distance < 5 && distance > - 5) {
                //print("/nI am pasing the player");
                if (b.getBulletYPos() == p.getPlayerYPos()) {
                    //print("\nI have hit the player");
                    p.setHit();
                    bullet.setHit();
                }
                else {
                    //print("\nI have missed");
                    bullet.setMiss();
                } 
            }
        }     
    }
    
    private void getHit(Player player, Enemy e) {
        
        if (player.getPlayerAttacking()) {
            target = e.getEnemyXPos();
            distance = abs(player.getPlayerXPos() - target);
            //print("\nTarget: ", target);
            //print("\nDX: ", distance);
            //print("\nattackbox: ", player.getPlayerAttackBoxW());
            if (distance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getDirection() != e.getDirection()) {
                    e.setHit();
                    //print("\nI have hit an enemy");
                }
                
            }
            
        }
    }

    private void getHit(Player player, EnemyRanged e) {
        
        if (player.getPlayerAttacking()) {
            target = e.getEnemyXPos();
            distance = abs(player.getPlayerXPos() - target);
            //print("\nTarget: ", target);
            //print("\nDX: ", distance);
            //print("\nattackbox: ", player.getPlayerAttackBoxW());
            if (distance < player.getPlayerAttackBoxW() + player.getPlayerHitBoxW()) {
                if (player.getDirection() != e.getDirection()) {
                    e.setHit();
                   //print("\nI have hit an enemy");
                }
                
            }
            
        }
    }
    
}









//setters
