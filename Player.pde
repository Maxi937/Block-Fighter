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
        rect(xpos + 15, ypos + 5, hitboxw, hitboxh);
        
        
        //draw character model
        for (int i = 0; i < 18; i++) {
            image(playerImages.get(0),xpos,ypos);
        }
    }
    
    void debugdisplayspritesheet(int numofimages) {
        //will display character sprite sheet on top of screen
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
            //background(255); 
            if (x >= width - 100) {
                row = row + 1;
                column = 0;
            }
            column = column + 1;
            
            x = column * scaleX;
            y = scaleY * row;
            
            
            //Draw Shapes
            image(playerImages.get(imgtoprint),x,y);
            imgtoprint = imgtoprint + 1;
        }
    }
    
    void hitboxcolour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }
}
