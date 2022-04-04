class Enemy{

    //---PROPERTIES---//
    
    //position
    private float xPos, yPos;
    private float pXpos;
    
    //game
    private int health;
    
    //movement
    private float maxSpeed, speedX, speedY;
    private boolean left, right, up;
    
    //animation properties
    private PImage[] enemyImages;
    private int currentFrame, loopFrames, frameOffset, delay;
    private boolean idle;
    private boolean attack;
    private boolean directionFacing;
    
    //collision
    private int hitboxh, hitboxw;
    private int attackhitboxW;
    private boolean onHit;

    //brain
    private float distance;
    private float target;
    
    //debug
    private boolean showAllFrames;
    
    //---CONSTRUCTOR---//
    
    Enemy() {
        //movement
        maxSpeed = 1.5;
        speedX = 0;
        speedY = 0;
        
        //animation
        enemyImages = l.getImageArray();
        loopFrames = 0;
        delay = 0;
    
        //game variables
        health = 100;
        
        //collision
        hitboxh = 40;
        hitboxw = 15;
        attackhitboxW = 15;
        
        //debug
        showAllFrames = false;

        //starting Position
        xPos = 600;
        yPos = level.getScreenBottom() - hitboxh;
        pXpos = xPos;
    }
    
    //---METHODS---//
    
    //draw character on screen
    public void display() {
        //draw hitbox & draw character model - character model follows hitbox
        rect(xPos, yPos, hitboxw, hitboxh);
    }
    
    //update character ie. update health and movement position, animation state
    public void update() {
        animation();
        controller();
        brain();
        print("\nXpos: ", xPos, "\tpXpos: ",pXpos);
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
            
        }
        
        if (showAllFrames) {
            //debugdisplayspritesheet(l.getNumofImagesInArray(playerImages));
        }
    }
    
    // animations
    private void animation() {
        if (pXpos == xPos) {
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
        if (pXpos < xPos) {
            frameOffset = 42;
            loopFrames = 7;
            idle = false;
            directionFacing = true;
            attack = false;
            }
            
            if (pXpos > xPos) {
            frameOffset = 50;
            loopFrames = 7;
            idle = false;
            directionFacing = false;
            attack = false;
            }
    
    
        
        //animation delay
         if (delay ==  0){
             pXpos = xPos;
         }

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
        
        image(enemyImages[(currentFrame + frameOffset)],xPos - hitboxw,yPos - 5);
    }
    
/*   
    private void debugdisplayspritesheet(int numofimages) {
        /*will display character sprite sheet on top of screen
        46x 50 was the size of each tile on the sprite sheet
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
            fill(0, 0, 0);
            text(i,x,y + 12);
    
        }
    }*/
    
    private void hitboxcolour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }

    
    private void brain() {

        //auto-move to player pos
        if (p.getPlayerPos() < xPos -(hitboxw*2)) {
            distance = p.getPlayerPos() - xPos;
            target = distance -15;
            xPos = xPos - (maxSpeed);
        }
        else if (p.getPlayerPos() > xPos+(hitboxw*2)) {
            distance = p.getPlayerPos() - xPos;
            target = distance -15;
            xPos = xPos + maxSpeed;
        }

        //attack if within range
        if (p.getPlayerPos() >= xPos -(hitboxw*2)) {
            attack = true;
        }
        else if (p.getPlayerPos() <= xPos -(hitboxw*2)){
            attack = true;
        }
    }

}
