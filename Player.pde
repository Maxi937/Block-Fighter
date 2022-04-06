public class Player {

//---PROPERTIES---//
    
    //position
    float xPos, yPos;
    
    //game
    int health;
    int attackDelay;
   
    //movement
    float maxSpeed, speedX, speedY;
    boolean left, right, up, duck;
    boolean directionFacing, idle,attack;
    
    //animation properties
    PImage[] playerImages;
    int currentFrame, loopFrames, frameOffset, delay;
    
    //collision

    int hitboxh, hitboxw;
    int attackhitboxW;
    
    //debug
    boolean showAllFrames;
    
//---CONSTRUCTOR---//
    Player() {
        //movement
        maxSpeed = 2;
        speedX = 0;
        speedY = 0;
        
        //animation
        playerImages = l.getImageArray();
        loopFrames = 0;
        delay = 0;
        directionFacing = true;
        
        //game variables
        health = 100;
        attackDelay = 40;

        
        //collision
        hitboxh = 40;
        hitboxw = 15;
        attackhitboxW = 15;
        
        //debug
        showAllFrames = false;

        //starting Position
        xPos = 50;
        yPos = level.getScreenBottom()-hitboxh;
    }
    
//---METHODS---//
    
    //update character ie. update health and movement position, animation state
    public void update() {
        animation();
        controller();
        display();
        print("\nXpos: ", xPos, "Width: ", width);
    }

    //draw character on screen
    private void display() {
        //draw hitbox & draw character model - character model follows hitbox
        if (duck == true){
            rect(xPos, yPos + (hitboxh/2), hitboxw, hitboxh/2);

        }
        else {
            rect(xPos, yPos, hitboxw, hitboxh);
        }
    }
    
    private void controller() {
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

            if (attackDelay ==  0) {
                attack = false;
            }
            attackDelay = (attackDelay + 1) % 40;
        }

        if (duck) {
            //need to shorten hitbox
        
            idle = false;
            attack = false;
            left = false;
            right = false;
        }


        
        if (showAllFrames) {
            debugdisplayspritesheet(l.getNumofImagesInArray(playerImages));
        }
    }
    
    // animations
    private void animation() {
        idle = true;
    
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 28;
                loopFrames = 0;
                    if (duck) {
                        frameOffset = 8;
                        loopFrames = 0;
                    }    
            }
            if (directionFacing == false) {
                frameOffset = 29;
                loopFrames = 0; 
                   if (duck) {
                        frameOffset = 9;
                        loopFrames = 0;
                    }  
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
            duck = false;
        }

        //running
        if (right) {
            frameOffset = 42;
            loopFrames = 7;
            duck = false;
            idle = false;
            attack = false;
            directionFacing = true;
        }
            
        if (left) {
            frameOffset = 50;
            loopFrames = 7;
            idle = false;
            duck = false;
            attack = false;
            directionFacing = false;
        }

    
        //animation delay
        if (delay ==  0 & loopFrames >= 1) {
            currentFrame = (currentFrame + 1) % loopFrames;
        }
        else if (idle == true){
            currentFrame = 0;
        }

        delay = (delay + 1) % 5;
        
        //display animation
        //print("\nCurrent Frame: ", currentFrame);
        //print("\nFrame Offset: ", frameOffset);
        //print("\nloop Frames: ", loopFrames);
        //print("\nloop Frames: ", loopFrames);
        //print("\nAccesing Image at array: ", currentFrame + frameOffset);

        //play animation from animation array
        image(playerImages[(currentFrame + frameOffset)],xPos - hitboxw,yPos - 5);
    }
    
    private void debugdisplayspritesheet(int numofimages) {
        /*will display character sprite sheet on top of screen
        46x 50 was the size of each tile on the sprite sheet*/
        int scaleX = 46;
        int scaleY = 50;
        
   
        float y;
        float x;
        int row;
        int column;
        
        x = scaleX;
        y = 0;
        row = 0;
        column = 0;
        
        for (int i = 0; i < numofimages; i++) {
            //ifthe sprite sheet displays pass the screen size - start a new row offset by size of tile
            if (x >= width - 100) {
                row = row + 1;
                column = 0;
            }
            column = column + 1;
            
            x = column * scaleX;
            y = scaleY * row;


            
            //Draw Shape
            image(playerImages[i],x,y);
            fill(200, 0, 0);
            text(i,x,y + 12);
    
        }
    }

    private void hit(){

    }
    
    //getters
    public float getPlayerPos (){
        return xPos;
    }

    public int getPlayerAttackBox (){
        return int(xPos);
    }

    //setters
    public void setPlayerXpos(int xPos){
        this.xPos = xPos;
    }

    private void setHitBoxColour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }

    //controls
    private void playerControls(boolean keyPressed) {
        if (key == 'a') {
            left = true;
        }
        
        if (key == 'd') {
            right = true;  
        }

        if (key == 'e') {
            attack = true;  
        }

        if (key == 's') {
            duck = true;
        }        
        
        if (key == ']') {
            showAllFrames = true;
        } 
    }
    
    
    private void playerControls() {
        if (key ==  'a') {
            left = false;
        }
        
        if (key ==  'd') {
            right = false;
        }

        if (key ==  ']') {
            showAllFrames = false;
        }
    }

}
