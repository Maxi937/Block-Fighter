class Player {
    //---properties---//
    
    //position
    float xPos, yPos;
    
    //game
    int health;

    //movement
    float maxSpeed, speedX, speedY;

    //animation properties
    int currentFrame, loopFrames, frameOffset, delay;
    
    //collision
    int hitboxh, hitboxw;
    
    //---constructor---//
    Player() {
        //starting Position
        xPos = 50;
        yPos = height - 150;

        //movement
        maxSpeed = 5;
        speedX = 0;
        speedY = 0;
        
        //game variables
        health = 100;
        
        //collision
        hitboxh = 40;
        hitboxw = 15;
        
    }
    
    //---methods---//

    //draw hitbox & draw character model - character model follows hitbox
    private void display() {
        controller();
        
        rect(xPos, yPos, hitboxw, hitboxh);
        

        for (int i = 0; i < 18; i++) {
            image(playerImages.get(0),xPos-hitboxw,yPos-5);
        }
    }

    //controller
    private void controller(){
        if (keyPressed){
            if (key == 'a'){
                speedX =- maxSpeed;
                xPos = xPos + speedX;
            }
            if (key == 'd'){
                speedX =+ maxSpeed;
                xPos = xPos + speedX;
            }

            if (key == '}') {
                debugdisplayspritesheet(playerImages.size() - 1);
            }
        }
    }

    //animations
    private void animation(){

    }
    
    //will display character sprite sheet on top of screen
    private void debugdisplayspritesheet(int numofimages) {
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
    
    private void hitboxcolour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }
}
