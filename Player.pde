class Player {
    //---properties---//
    
    //position
    float xpos, ypos;
    
    //game
    int health;
    
    //collision
    int hitboxh;
    int hitboxw;
    
    //---constructor---//
    Player() {
        //starting Position
        xpos = 50;
        ypos = height - 150;
        
        //game variables
        health = 100;
        
        //collision
        hitboxh = 40;
        hitboxw = 15;
        
    }
    
    //---methods---//
    void display() {
        //draw hitbox
        rect(xpos, ypos, hitboxw, hitboxh);
        
        //draw character model - character model follows hitbox
        for (int i = 0; i < 18; i++) {
            image(playerImages.get(0),xpos-hitboxw,ypos-5);
        }
    }
    
    void debugdisplayspritesheet(int numofimages) {
        //will display character sprite sheet on top of screen

        //46 x 50 was the size of each tile on the sprite sheet, this should be changed to a variable so it works if the class is extended
        int scaleX = 46;
        int scaleY = 50;

        int imgtoprint = 0;
        float y;
        float x;
        int row;
        int column;
        
        x = scaleX;
        y = 0;
        row = 0;
        column = 0;
        
        for (int i = 0; i <= numofimages; i++) {
            //if the sprite sheet displays pass the screen size - start a new row offset by size of tile
            if (x >= width - 100) {
                row = row + 1;
                column = 0;
            }
            column = column + 1;
            
            x = column * scaleX;
            y = scaleY * row;
            
            //Draw Shape
            image(playerImages.get(imgtoprint),x,y);
            imgtoprint = imgtoprint + 1;
        }
    }
    
    void hitboxcolour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }
}
