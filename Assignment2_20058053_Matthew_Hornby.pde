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
    g.updateGame();
}


//Controls
void keyPressed() {
    p.playerControls(keyPressed);
}

void keyReleased() {
   p.playerControls();
}
