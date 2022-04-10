public class Bullet {

//---PROPERTIES---//
    //location
    private float bulletxPos;
    private float bulletyPos;

    //movement
    boolean bulletDirection;
    private int bulletSpeed;

    //shooting
    boolean shooting;
    boolean hit;
    boolean miss;

    //images
    PImage[] bulletImages;

    //animation
    int bulletFrameOffset;

    //bulletID
    int bulletNumber;



//---CONSTRUCTOR---//
Bullet(int bulletNumber) {
    bulletSpeed = 7;
    shooting = false;
    hit = false;
    miss = false;
    this.bulletNumber = bulletNumber;
}
    
//---METHODS---//
    public void update(){
        animations();

        if (miss == true){
            killBullet();
            moveBullet();
            display();  
        }

        if (shooting == true && miss == false){
            killBullet();
            moveBullet();
            hit();
            display();
        }
    }

    private void display(){
        fill(0, 0, 0);
        rect(bulletxPos, bulletyPos, 10, 10);
    }

    private void animations(){
        if (shooting) {
            if (bulletDirection) {
                bulletFrameOffset = 1;
            }
            if (bulletDirection  == false) {
                bulletFrameOffset = 0;
            }      
        
        image(bulletImages[bulletFrameOffset],bulletxPos,bulletyPos-5,30,30);
    }

    }


    private void moveBullet(){
        if (bulletDirection == true){
            bulletxPos = bulletxPos + bulletSpeed;
        }
        else {
           bulletxPos = bulletxPos - bulletSpeed;
        }
    }
    private void hit(){
         if (hit == true){
            shooting = false;
        }
    }

    private void killBullet(){
       if (bulletxPos >= width){
           shooting = false;
        }   
        if (bulletxPos < width-width){
            shooting = false;
        }         
    }

    //getters
    public float getBulletXPos() {
        return bulletxPos;
    }

    public float getBulletYPos() {
        return bulletyPos;
    }

    public boolean getShooting() {
        return shooting;
    }

    public boolean getBulletDirection() {
        return bulletDirection;
    }

    public int getBulletNumber() {
        return bulletNumber;
    }


    //setters
    public void setBulletXPos(float xPos, float yPos, boolean directionFacing) {
        bulletxPos = xPos;
        bulletyPos = yPos;
        shooting = true;
        miss = false;
        hit = false;
        bulletDirection = directionFacing;
    }

    public void setHit(){
        hit = true;
    }

    public void setMiss(){
        miss = true;
    }

    public void setImageArray(PImage[] imageArray){
        bulletImages = imageArray;
    }

}
