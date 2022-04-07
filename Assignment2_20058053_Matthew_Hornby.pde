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
    PImage[] effectImages;


void setup() {
    size(800, 600);
    background(255);
    
    //Game
    g = new Game();

    //create Loader Object
    l = new Loader();

    //create Level Object
    level = new Level();
    levelImages = l.loadSpritesheets("level", level);
    level.setImageArray(levelImages);

    //create Player Object
    p = new Player();
    playerImages = l.loadSpritesheets("player", p);
    p.setImageArray(playerImages);
    
    //create Enemy Object
    enemy = new Enemy();
    enemyImages = l.loadSpritesheets("enemy", enemy);
    enemy.setImageArray(enemyImages);
        
    //create Ranged Enemy Object
    enemyRanged = new EnemyRanged();
    enemyImages = l.loadSpritesheets("player", p);
    enemyRanged.setImageArray(enemyImages);

    //create Bullet Object
    bullet = new Bullet();
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
