class Player {
    //---PROPERTIES---//
    
    //position
    float xPos, yPos;
    
    //game
    int health;
    
    //movement
    float maxSpeed, speedX, speedY;
    boolean left, right, up;
    
    //animation properties
    int currentFrame, loopFrames, frameOffset, delay;
    boolean directionFacing;
    boolean idle;
    boolean attack;
    
    //collision
    int hitboxh, hitboxw;
    int attackhitboxW;
    
    //debug
    boolean showAllFrames;
    
    //---CONSTRUCTOR---//
    
    Player() {
        //starting Position
        xPos = 50;
        yPos = height - 150;
        
        //movement
        maxSpeed = 2;
        speedX = 0;
        speedY = 0;
        
        //animation
        loopFrames = g.playerImages.size() - 1;
        delay = 0;
        directionFacing = true;
        
        //game variables
        health = 100;
        
        //collision
        hitboxh = 40;
        hitboxw = 15;
        attackhitboxW = 20;
    
    
        
        //debug
        showAllFrames = false;
    }
    
    //---METHODS---//
    
    //draw character on screen
    private void display() {
        //draw hitbox & draw character model - character model follows hitbox
        rect(xPos, yPos, hitboxw, hitboxh);
    }
    
    //update character ie. update health and movement position
    private void update() {
        
        animation();
        controls();
        delay = (delay + 1) % 5;
    }
    
    private void controls() {
        if (left) {
            speedX = -maxSpeed;
            xPos = xPos + speedX;
        }
        
        if (right) {
            speedX = maxSpeed;
            xPos = xPos + speedX;
        } 

        if (attack) {
            if (directionFacing == false){
                rect(xPos+((attackhitboxW)*-1), yPos, attackhitboxW, hitboxh);
            }
            else {
                rect(xPos+hitboxw, yPos, attackhitboxW, hitboxh);
            }
            
        }
        
        if (showAllFrames) {
            debugdisplayspritesheet(g.playerImages.size() - 1);
        }
    }
    
    // animations
    private void animation() {
        if (xPos == xPos) {
            idle = true;
        }
        
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 28;
                loopFrames = 0;    
            }
            if (directionFacing == false) {
                frameOffset = 29;
                loopFrames = 0;    
            }          
        }

        //attack
        if (attack) {
            if (directionFacing) {
                frameOffset = 0;
                loopFrames = 3;               
            }
            else {
                frameOffset = 4;
                loopFrames = 3;
            }

            idle = false;
            right = false;
            left = false;
            attack = true;
        }

        //running
        if (right) {
            frameOffset = 42;
            loopFrames = 7;
            idle = false;
            directionFacing = true;
            attack = false;
            }
            
            if (left) {
            frameOffset = 50;
            loopFrames = 7;
            idle = false;
            directionFacing = false;
            attack = false;
            }
    
    
        
        //animation delay
        if (delay ==  0 & loopFrames >= 1) {
            currentFrame = (currentFrame + 1) % loopFrames;
        }
        else if (idle == true){
            currentFrame = 0;
        }
        
        //display animation
        print("\nCurrent Frame: ", currentFrame);
        print("\nFrame Offset: ", frameOffset);
        print("\nloop Frames: ", loopFrames);
        print("\nloop Frames: ", loopFrames);
        print("\nAccesing Image at array: ", currentFrame + frameOffset);
        
        image(g.playerImages.get(currentFrame + frameOffset),xPos - hitboxw,yPos - 5);
    }
    
    
    private void debugdisplayspritesheet(int numofimages) {
        /*will display character sprite sheet on top of screen
        46x 50 was the size of each tile on the sprite sheet*/
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
            //ifthe sprite sheet displays pass the screen size - start a new row offset by size of tile
            if (x >= width - 100) {
                row = row + 1;
                column = 0;
            }
            column = column + 1;
            
            x = column * scaleX;
            y = scaleY * row;
            
            //Draw Shape
            image(g.playerImages.get(imgtoprint),x,y);
            fill(0, 0, 0);
            text(i,x,y + 12);
            imgtoprint = imgtoprint + 1;
        }
    }
    
    private void hitboxcolour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }
    
    private void keyPressed() {
        if (key == 'a') {
            left = true;
        }
        
        if (key == 'd') {
            right = true;  
        }

        if (keyCode == 32) {
            attack = true;  
        }        
        
        if (key == ']') {
            showAllFrames = true;
        } 
    }
    
    
    private void keyReleased() {
        if (key ==  'a') {
            left = false;
        }
        
        if (key ==  'd') {
            right = false;
        }

        if (keyCode == 32) {
            attack = false;  
        }       

        if (key ==  ']') {
            showAllFrames = false;
        }
    }
}
