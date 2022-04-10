public class EnemyRanged {
    
//---PROPERTIES---//
    //position
    private float xPos, yPos;
    private float pXpos;
    
    //game
    private int maxHealth;
    private int damageTaken;
    
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
    private int attackRange;
    private int attackDamage;
    boolean death;
    boolean killEvent;
    
    //bullet
    private int bulletNumber;
 
//---CONSTRUCTOR---//
    
    EnemyRanged(int difficulty, int bulletNumber) {
        //movement
        maxSpeed = 0.5*difficulty+(random(0,1.0));
        speedX = 0;
        speedY = 0;
        
        //animation
        loopFrames = 0;
        delay = 0;
        
        //game variables
        maxHealth = 50*difficulty;
        attackDamage = 10*difficulty;
        
        //collision
        hitboxh = 40;
        hitboxw = 15;
        attackhitboxW = 15;
        hit = false;
        
        
        //starting Position
        xPos = 820+random(0,30);
        yPos = level.getGround() - hitboxh;
        pXpos = xPos;

        //brain
        attackRange = 200*difficulty+int(random(0,30));
        attack = false;
        killEvent = false;

        //bullet
        this.bulletNumber = bulletNumber;

    }
    
    //---METHODS---//
    
    //update character ie. update health and movement position, animation state, draw character on screen
    public void update() {
        animation();
        controller();
        brain();
        display();
    }
    
    public void display() {
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
            if (frameCount % 160 == 0) {
                bullet[bulletNumber].setBulletXPos(xPos, yPos, directionFacing);
            }
        }
    }

    private void takeDamage(int damageTaken) {
            hit = false;
            this.damageTaken = this.damageTaken + damageTaken;
            blood = true;
                if (this.damageTaken >= maxHealth){
                    death = true;
                    killEvent = true;
                }
    
    }
    
    // animations
    private void animation() {
        if (pXpos == xPos) {
            idle = true;
        }
        
        if (idle == true) {
            if (directionFacing) {
                frameOffset = 31;
                loopFrames = 0;    
            }
            if (directionFacing == false) {
                frameOffset = 32;
                loopFrames = 0;    
            }       
        }
        
        // attack
        if (attack) {
            if (directionFacing) {
                frameOffset = 0;
                loopFrames = 3;
            }
            else{
                frameOffset = 4;
                loopFrames = 3;
            }
            
            idle = false;
            right = false;
            left = false;
        }
        
        //running
        if (pXpos < xPos) {
            frameOffset = 37;
            loopFrames = 7;
            idle = false;
            directionFacing = true;
            attack = false;
        }
        
        if (pXpos > xPos) {
            frameOffset = 45;
            loopFrames = 7;
            idle = false;
            directionFacing = false;
            attack = false;
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
            if (delay ==  0) {
                effectcurrentFrame = (effectcurrentFrame + 1) % effectloopFrames;
                    if (effectcurrentFrame == 0) {
                        blood = false;
                }
            }
            image(enemyImages[effectcurrentFrame + effectframeOffset],xPos - 2,yPos - 15,30,30);
        }
        
        //animation delay
        if (delay ==  0) {
            pXpos = xPos;
        }
        
        if (delay ==  0 & loopFrames >= 1) {
            currentFrame = (currentFrame + 1) % loopFrames;  
        }
        else if (idle == true || hit == true) {
            currentFrame = 0;
        }
        
        delay = (delay + 1) % 5;
        
        image(enemyImages[(currentFrame + frameOffset)],xPos - hitboxw,yPos - 5);
    }
    
    private void brain() {
    
        
        //auto - move to attack Range
        if (p.getPlayerXPos() <= xPos - attackRange) {
            xPos = xPos - (maxSpeed);
            }
        else if (p.getPlayerXPos() >= xPos + attackRange) {
            xPos = xPos + maxSpeed;
            }
        
        //attack if within range
            if (p.getPlayerXPos() < xPos - attackRange) {
                attack = true;
                }
            else if (p.getPlayerXPos() < xPos + attackRange) {
                attack = true;
            }

        //make enemy auto face the player

            if(p.getPlayerXPos() > xPos){
                    directionFacing = true;
            }
            else {
                directionFacing = false;
            }       
    }

    //getters
    public float getEnemyXPos(){
        return xPos;
    }

    public boolean getDirection(){
        return directionFacing;
    }

    public boolean getDeath(){
        return death;
    }

    public boolean getKillEvent(){
        return killEvent;
    }

    public int getEnemyAttackDamage(){
        return attackDamage;
    }

    public int getEnemyRHealth(){
        return maxHealth;
    }

    public int getEnemyRAttackRange(){
        return attackRange;
    }


    

    //setters
    public void setHitBoxColour(int r, int g, int b,int a) {
        fill(r,g,b,a);
        }
    
    public void setHit(int damageTaken) {
        hit = true;
        takeDamage(damageTaken);
    }
    
    public void setImageArray(PImage[] imageArray){
        enemyImages = imageArray;
    } 

    public void setKillEvent(boolean killEvent){
        this.killEvent = killEvent;
    }

    public void setDeath(boolean death){
        this.death = death;
    }

    public void setBulletHit(){
        this.death = death;
    }

    public void setXPos(float xPos){
        this.xPos = xPos;
    }

    public void setDamageTaken(int damageTaken){
        this.damageTaken = damageTaken;
    }

    
}

    
