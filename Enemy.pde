public class Enemy{

//---PROPERTIES---//
    
    //position
    private float xPos, yPos;
    private float pXpos;
    
    //game
    private int health;
    private int damageTaken;
    
    //movement
    private float maxSpeed, speedX;
    private boolean left, right;
    
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
    private boolean death;
    private boolean onHit;
    private int attackDamage;

    //debug
    private boolean showAllFrames;
    
//---CONSTRUCTOR---//
    
    Enemy(int difficulty) {
        //movement
        maxSpeed = 0.5*difficulty;
        speedX = 0;
        
        //animation
        loopFrames = 0;
        delay = 0;
    
        //game variables
        health = 50*difficulty;
        attackDamage = 2*difficulty;
        onHit = false;
        damageTaken = 0;
        
        //collision
        hitboxh = 25;
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
        display();
        println("HIT:" , hit);
            if (death == true){
                xPos = xPos + width;
                death = false;
            }
    
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

    private void takeDamage(int damageTaken) {
            hit = false;
            this.damageTaken = this.damageTaken + damageTaken;
            blood = true;
                if(directionFacing)
                {
                    xPos = xPos - 40;
                }
                else{
                    xPos = xPos + 40;
                }

                if (damageTaken >= health){
                    death = true;
                }
        
    }
    
    // animations
    private void animation() {
        if (pXpos == xPos) {
            idle = true;
        }
        
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 0;
                loopFrames = 0;    
            }
            if (directionFacing == false) {
                frameOffset = 4;
                loopFrames = 0;    
            }          
        }

        // attack
        if (attack) {
            if (directionFacing) {
                frameOffset = 9;
                loopFrames = 3;               
            }
            else {
                frameOffset = 14;
                loopFrames = 3;
            }

            idle = false;
            right = false;
            left = false;
            attack = true;
        }

        //running
        if (pXpos < xPos) {
            frameOffset = 18;
            loopFrames = 10;
            idle = false;
            directionFacing = true;
            attack = false;
            }
            
            if (pXpos > xPos) {
            frameOffset = 29;
            loopFrames = 10;
            idle = false;
            directionFacing = false;
            attack = false;
            }

        //blood
        if (blood) {
            if (directionFacing) {
                frameOffset = 1;
                loopFrames = 0;
            }
            if (directionFacing == false) {
                frameOffset = 5;
                loopFrames = 0;
            }      
            effectframeOffset = 39;
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
        if (p.getPlayerXPos() < xPos - (hitboxw*2)) {
            xPos = xPos - (maxSpeed);
        }
        else if (p.getPlayerXPos() > xPos+(hitboxw*2)) {
            xPos = xPos + maxSpeed;
        }

        //attack if within range
        if (p.getPlayerXPos() >= xPos -(hitboxw*2)) {
                if (frameCount % 160 == 0){
                    attack = true; 
                    if (frameCount%240 == 0){
                        attack = false;
                    }
                }  
            }
             
        else if (p.getPlayerXPos() <= xPos -(hitboxw*2)){
                if (frameCount % 160 == 0){
                    attack = true; 
                    if (frameCount%240 == 0){
                        attack = false;
                    }
                }     
            }
        

    }
                
    private void death(){
        if (death == true){
            xPos = xPos + width;
            print("\nI am dead");
        }
    }

    //getters
    public float getEnemyXPos(){
        return xPos;
    }

    public boolean getDirection() {
        return directionFacing;
    }

    public boolean getDeath(){
        return death;
    }

    public boolean getEnemyAttacking() {
        return attack;
    }

    public int getEnemyAttackBoxW() {
        return attackhitboxW;
    }

    public int getEnemyHitBoxW() {
        return hitboxw;
    }

    public int getEnemyAttackDamage(){
        return attackDamage;
    }

    public int getEnemyHealth(){
        return health;
    }

    //setters
    public void setHitBoxColour(int r, int g, int b,int a) {
        fill(r,g,b,a);
    }

    public void setHit(int damageTaken) {
        hit = true;
        takeDamage(damageTaken);
    }

    public void setOnHit() {
        onHit = true;
    }

    public void setImageArray(PImage[] imageArray){
        enemyImages = imageArray;
    }



}
