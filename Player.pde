public class Player {
    
//---PROPERTIES---//
    
    //position
    float xPos, yPos;
    
    //game
    int health;
    int attackDelay;
    
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
    boolean hit;
    
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
        hitboxw = 17;
        attackhitboxW = 15;
        hit = false;
        
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
            debugdisplayspritesheet(l.getNumofImagesInArray(playerImages));
        }
    }
    
    private void takeDamage() {
        if (hit == true) {
            health = health - 15;
            hit = false;
            blood = true;
            //print("\nhealth:", health);
            //print("\nhit: ", hit);
        }
    }
    
    // animations
    private void animation() {
        idle = true;
        
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 43;
                loopFrames = 0;
                if (duck) {
                    frameOffset = 23;
                    loopFrames = 0;
                }    
            }
            if (directionFacing == false) {
                frameOffset = 44;
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
            frameOffset = 57;
            loopFrames = 7;
            duck = false;
            idle = false;
            attack = false;
            directionFacing = true;
        }
        
        if (left) {
            frameOffset = 65;
            loopFrames = 7;
            idle = false;
            duck = false;
            attack = false;
            directionFacing = false;
        }
        
        //jumping
        if (canJump == false) {
            if (directionFacing) {
                frameOffset = 45;
                loopFrames = 1;
            }
            if (directionFacing == false) {
                frameOffset = 47;
                loopFrames = 1;
            }      
            duck = false;
            attack = false;
        } 


        //blood
        if (blood) {
            if (directionFacing) {
                frameOffset = 37;
                loopFrames = 0;
            }
            if (directionFacing == false) {
                frameOffset = 40;
                loopFrames = 0;
            }      
            effectframeOffset = 8;
            effectloopFrames = 10;
            attack = false;
            right = false;
            left = false;
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
    
    private void jumping() {
        yPos = yPos - 50;
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
