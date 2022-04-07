import javax.swing.*;


//Objects required in the program
Player p;
Game g;
Loader l;
Level level;
Enemy enemy;
EnemyRanged enemyRanged;
Bullet bullet;
CollisionDetector c;


void setup() {
    size(800, 600);
    background(255);
    
    //Game
    g = new Game();
    g.loadGame();
}

void draw() {
    //update game - check for collisions, update score, spawn enemies
    g.updateGame();

    //update Level - draw level background
    level.update();

    //update Player - update player location, draw player, update animations
    p.setHitBoxColour(0,0,255,50);
    p.update();

    //update Enemy - update enemy location, draw enemy, update animations
    enemy.setHitBoxColour(255,0,0,50);
    if (enemy.getDeath() == false){
            enemy.update();
            g.getHit(p, enemy);
            g.getHit(enemy, p);
        }

    //update Enemy Ranged - update enemy location, draw enemy, update animations
    enemyRanged.setHitBoxColour(255,0,0,50);
    if (enemyRanged.getDeath() == false){
            enemyRanged.update();
            g.getHit(p, enemyRanged);
            g.getHit(bullet, p);
        }

    //update bullet object - update bullet location, kill bullet
    bullet.update(); 

    
    print("\nScore:", g.getScore());
}


//Controls
void keyPressed() {
    p.playerControls(keyPressed);
}

void keyReleased() {
   p.playerControls();
}
