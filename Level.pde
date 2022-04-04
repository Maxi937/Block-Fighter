class Level {
     
    //---PROPERTIES---//

    private int screenBorder;

    //---CONSTRUCTOR---//
    Level() {
        screenBorder = width - 7;
    }
    
    //---METHODS---//
    public void display(){
        background(255, 255, 255);
        drawBorder();
    }

    private void drawBorder() {
        fill(0, 255,0, 50);
        rect(3, 0, screenBorder, height);
    }
}