public class Enemy{

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
    private boolean blood;
    private int effectframeOffset, effectloopFrames, effectcurrentFrame;
    
    //collision
    private int hitboxh, hitboxw;
    private int attackhitboxW;
    private boolean hit;

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
        hit = false;
        
        //debug
        showAllFrames = false;

        //starting Position
        xPos = 600;
        yPos = level.getGround() - hitboxh;
        pXpos = xPos;
    }
    
//---METHODS---//
    
    //update character ie. update health and movement position, animation state, draw character on screen
    public void update() {
        animation();
        controller();
        brain();
        takeDamage();
        display();
    }

    public void display() {
        //draw hitbox & draw character model - character model follows hitbox
        rect(xPos, yPos, hitboxw, hitboxh);
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
        
    }

    private void takeDamage() {
        if (hit == true) {
            health = health - 15;
            hit = false;
            blood = true;
            print("\nhealth:", health);
            print("\nEnemy hit: ", hit);
        }
    }
    
    // animations
    private void animation() {
        if (pXpos == xPos) {
            idle = true;
        }
        
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 43;
                loopFrames = 0;    
            }
            if (directionFacing == false) {
                frameOffset = 44;
                loopFrames = 0;    
            }          
        }

        // attack
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
            frameOffset = 57;
            loopFrames = 7;
            idle = false;
            directionFacing = true;
            attack = false;
            }
            
            if (pXpos > xPos) {
            frameOffset = 65;
            loopFrames = 7;
            idle = false;
            directionFacing = false;
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

            image(enemyImages[effectcurrentFrame + effectframeOffset],xPos - 2,yPos - 15,30,30);
        }
    
        //animation delay
         if (delay ==  0){
             pXpos = xPos;
        }

        if (delay ==  0 & loopFrames >= 1) {
            currentFrame = (currentFrame + 1) % loopFrames;  
        }
        else if (idle == true || hit == true){
            currentFrame = 0;
        }

        delay = (delay + 1) % 5;
        image(enemyImages[(currentFrame + frameOffset)],xPos - hitboxw,yPos - 5);
    }

    
    
    private void brain() {

        //auto-move to player pos
        if (p.getPlayerXPos() < xPos -(hitboxw*2)) {
            xPos = xPos - (maxSpeed);
        }
        else if (p.getPlayerXPos() > xPos+(hitboxw*2)) {
            xPos = xPos + maxSpeed;
        }

        //attack if within range
        if (p.getPlayerXPos() >= xPos -(hitboxw*2)) {
            attack = true;
        }
        else if (p.getPlayerXPos() <= xPos -(hitboxw*2)){
            attack = true;
        }
    }

    //getters
    public float getEnemyXPos(){
        return xPos;
    }

    public boolean getDirection() {
        return directionFacing;
    }

    //setters
    public void setHitBoxColour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }

    public void setHit() {
        hit = true;
    }
}
