class Level {
     
    //---PROPERTIES---//
    private int screenBottom;
    private int screenBorderOffset;
    PImage[] levelImages;
    int fimageW;
    int bimageW;

    //---CONSTRUCTOR---//
    Level() {
        levelImages = l.getImageArray();
        screenBorderOffset = 2;
        screenBottom = height-100;
        fimageW = 96;
        bimageW = 256;
    }
    
    //---METHODS---//
    public void display(){
        background(0, 0, 0);
        drawGround();
        drawBackground(bimageW);
        drawForeground(fimageW);
        //screenBorder();
    }


    private void screenBorder() {
        fill(0, 255,0, 50);
        rect(screenBorderOffset, 0, width - (screenBorderOffset*2), screenBottom);
    }

    private void drawGround() {
        fill(0, 0, 0);
        rect(0, screenBottom+5, width, screenBottom);
    }
    
    private void drawBackground(int imageW) {
        for (int i = 0; i < width/imageW; ++i) {
           image(levelImages[2], imageW*i, screenBottom-69, 256,75);
        }
    }


    private void drawForeground(int imageW) {
        for (int i = 0; i < width/imageW+1; ++i) {
            image(levelImages[0], imageW*i, screenBottom, 96, 103);
        }
        
    }

    //getters
    public int getScreenBottom(){
        return screenBottom;
    }
}
