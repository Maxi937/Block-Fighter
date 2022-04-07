class Level {
     
    //---PROPERTIES---//
    private float screenBottom;
    private int screenBorderOffset;
    private int groundOffset;
    private float gravity;

    int[][] levelDimensions;
    int fimageW;
    int bimageW;

    PImage[] levelImages;
    

    //---CONSTRUCTOR---//
    Level() {
        levelImages = l.getImageArray();
        gravity = 2;
        screenBorderOffset = 2;
        groundOffset = 5;
        screenBottom = height-100;
        fimageW = 96;
        bimageW = 256;
    }
    
    //---METHODS---//
     public void update(){
         display();
         resetPlayerPosition();
     }


    public void display(){
        background(20, 20, 20);
        //screenBorder();
        drawGround();

        //levelOne();
        levelTwo();

        letterBox();
    }

    private void screenBorder() {
        fill(0, 255,0, 50);
        rect(screenBorderOffset, 0, width - (screenBorderOffset*2), screenBottom);
    }

    private void letterBox(){
        fill(0,0,0);
        rect(0, 0, width, 60);
        rect(0, height-60,width, 60);

    }

    private void drawGround() {
        fill(0, 0, 0);
        rect(0, screenBottom+groundOffset, width, screenBottom);
    }

    private void levelOne(){

        //background
        for (int i = 0; i < width/bimageW; ++i) {
           image(levelImages[7], bimageW*i, screenBottom-69, 256,75);
        }

        //foreground
        for (int i = 0; i < width/fimageW+1; ++i) {
            image(levelImages[5], fimageW*i, screenBottom, 96, 103);
        }

    }

     private void levelTwo(){

        //background
        for (int i = 0; i < width/384+1; ++i) {
        image(levelImages[0],384*i, screenBottom-450, 384,224);
        }


        for (int i = 0; i < width/160+1; ++i) {
        image(levelImages[1], 160*i, screenBottom-340, 160,224);
        image(levelImages[1], 160*i, screenBottom-280, 160,224);
        image(levelImages[1], 160*i, screenBottom-200, 160,224);
        }

        image(levelImages[3], 0, screenBottom-190, 384,224);
           

        //foreground
        for (int i = 0; i < width/65+1; ++i) {
            image(levelImages[4], 64*i, screenBottom-20, 65, 53);
        }

    }


    
    private void resetPlayerPosition(){
    if (p.getPlayerXPos() > width) {
        p.setPlayerXpos(0);
      }
    if (p.getPlayerXPos() < width-width) {
        p.setPlayerXpos(width);
      }
    }

    //getters
    public float getGround(){
        return screenBottom;
    }

    public float getGravity(){
        return gravity;
    }
}
