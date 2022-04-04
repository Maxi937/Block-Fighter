
import java.io.*;

//Objects required in the program
Player p;
Game g;
Loader l;
Level level;
Enemy enemy;


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
    p.keyPressed();
}

void keyReleased() {
   p.keyReleased();
}
