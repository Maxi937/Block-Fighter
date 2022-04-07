public class Player {
    
//---PROPERTIES---//
    
    //position
    float xPos, yPos;
    
    //game
    int health;
    int attackDelay;
    int attackDamage;
    
    //movement
    float maxSpeed, speedX, speedY;
    boolean left, right, up, canJump, jump, duck;
    boolean directionFacing, idle,attack;
    
    //animation properties
    PImage[] playerImages;
    boolean blood;
    int currentFrame, loopFrames, frameOffset, delay;
    int effectframeOffset, effectloopFrames, effectcurrentFrame;
    
    //collision
    int hitboxh, hitboxw;
    int attackhitboxW;
    boolean hit, block;
    
    //debug
    boolean showAllFrames;
    
//---CONSTRUCTOR---//
    Player() {
        //movement
        maxSpeed = 2;
        speedX = 0;
        speedY = 0;
        
        //animation
        loopFrames = 0;
        delay = 0;
        directionFacing = true;
        
        //game variables
        health = 100;
        attackDelay = 40;
        attackDamage = (20);
        
        //collision
        hitboxh = 40;
        hitboxw = 17;
        attackhitboxW = 15;
        hit = false;
        block = false;
        
        //debug
        showAllFrames = false;
        
        //starting Position
        xPos = 50;
        yPos = level.getGround() - hitboxh;
    }
    
//---METHODS---//
    
    //update character ie. update health and movement position, animation state
    public void update() {
        gravityPlayer();
        animation();
        takeDamage();
        controller();
        display();
    }
    
    //draw character on screen
    private void display() {
        if (duck == true) {
            rect(xPos, yPos + hitboxh / 2, hitboxw, hitboxh / 2);
        }
        else {
            rect(xPos, yPos, hitboxw, hitboxh);
        }
    }
    
    private void gravityPlayer() {
        if (level.getGround() > yPos + hitboxh) {
            yPos = yPos + level.getGravity();
            canJump = false;
        }
        //This is to catch an error where sometimes the ground and yPos would be off by one due to floating point numbers. This just
        if (yPos > level.getGround() - hitboxh) {
            yPos = level.getGround() - hitboxh;  
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
            if (directionFacing == false) {
                rect(xPos + ((attackhitboxW) *-  1), yPos, attackhitboxW, hitboxh);
            }
            else {
                rect(xPos + hitboxw, yPos, attackhitboxW, hitboxh);
            }
            
            if (attackDelay ==  0) {
                attack = false;
            }
            attackDelay = (attackDelay + 1) % 40;
        }
        
        if (duck) {
            idle = false;
            attack = false;
            left = false;
            right = false;
        }
        
        if (yPos + hitboxh == level.getGround()) {
            canJump = true;
        }
        
        if (showAllFrames) {
            debugdisplayspritesheet();
        }
    }
    
    private void takeDamage() {
        if (hit == true & block == false) {
            health = health - 15;
            hit = false;
            blood = true;
           // print("\nhealth:", health);
            //print("\nPLayer hit: ", hit);
        }
    }
    
    // animations
    private void animation() {
        idle = true;
        
        //idle
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 31;
                loopFrames = 0;
                if (duck) {
                    frameOffset = 23;
                    loopFrames = 0;
                }    
            }
            if (directionFacing == false) {
                frameOffset = 32;
                loopFrames = 0; 
                if (duck) {
                    frameOffset = 24;
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
            frameOffset = 37;
            loopFrames = 7;
            duck = false;
            idle = false;
            attack = false;
            directionFacing = true;
        }
        
        if (left) {
            frameOffset = 45;
            loopFrames = 7;
            idle = false;
            duck = false;
            attack = false;
            directionFacing = false;
        }
        
        //jumping
        if (canJump == false) {
            if (directionFacing) {
                frameOffset = 33;
                loopFrames = 1;
            }
            if (directionFacing == false) {
                frameOffset = 35;
                loopFrames = 1;
            }      
            duck = false;
            attack = false;
        } 
        if (block){
             if (directionFacing) {
                frameOffset = 53;
                loopFrames = 0;
            }
            if (directionFacing == false) {
                frameOffset = 54;
                loopFrames = 0;
            }      
            duck = false;
            left = false;
            right = false;
            attack = false;
            blood = false;
            jump = false;
        }

        //blood
        if (blood) {
            if (directionFacing) {
                frameOffset = 25;
                loopFrames = 0;
            }
            if (directionFacing == false) {
                frameOffset = 28;
                loopFrames = 0;
            }      
            effectframeOffset = 8;
            effectloopFrames = 10;
            attack = false;
            right = false;
            left = false;
            jump = false;
            if (delay ==  0) {
                effectcurrentFrame = (effectcurrentFrame + 1) % effectloopFrames;
                //print("\n",effectcurrentFrame);
                if (effectcurrentFrame == 0) {
                    blood = false;
                    }
            }

            image(playerImages[effectcurrentFrame + effectframeOffset],xPos - 2,yPos - 15,30,30);
        }
        
        
        //animation delay
        if (delay ==  0 & loopFrames >= 1) {
            currentFrame = (currentFrame + 1) % loopFrames;
        }
        else if (idle == true || hit == true) {
            currentFrame = 0;
        }
        
        delay = (delay + 1) % 5;
        
        image(playerImages[(currentFrame + frameOffset)],xPos - hitboxw,yPos - 5);
    }
    
    
    private void debugdisplayspritesheet() {
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
        
        for (int i = 0; i < playerImages.length; i++) {
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
    
    private void jumping() {
        yPos = yPos - 50;
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
        if (key == 'w') {
            if (canJump == true) {
                jumping();
            } 
        }
        if (key == 'q') {
            block = true;
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

        if (key == 'q') {
            block = false;
        }
        
        if (key ==  ']') {
            showAllFrames = false;
        }
    }

    //getters
    public float getPlayerXPos() {
        return xPos;
    }
    
    public float getPlayerYPos() {
        if (duck == true) {
            return yPos - hitboxh / 2;
        }
        else {
            return yPos;
        }
    }

    public int getPlayerAttackBoxW() {
        return attackhitboxW;
    }

    public int getPlayerHitBoxW() {
        return hitboxw;
    }

    public boolean getDirection() {
        return directionFacing;
    }

    public boolean getPlayerAttacking() {
        return attack;
    }

    public boolean getBlocking(){
        return block;
    }

    public int getAttackDamage(){
        return attackDamage;
    }
    
    //setters
    public void setPlayerXpos(int xPos) {
        this.xPos = xPos;
    }
    
    public void setHitBoxColour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }
    
    public void setHit() {
        hit = true;
    }

    public void setImageArray(PImage[] imageArray){
        playerImages = imageArray;
    }


    
}
