class Loader {
    
//---PROPERTIES---//
    String path;
    private int totalImages;

    //asset filepaths
    String playerSpriteSheetDirectory;
    String enemySpriteSheetDirectory;
    String bulletSpriteSheetDirectory;
    String enemyRangedSpriteSheetDirectory;
    String levelSpriteSheetDirectory;
    String effectSpriteSheetDirectory;

    //temp array
    PImage[] imageArray;
    
    
//---CONSTRUCTOR---//
    
    Loader() {
        playerSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Player\\";
        enemySpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Enemy\\";
        bulletSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bullet\\";
        enemyRangedSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\EnemyRanged\\";
        levelSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Level\\";
    }
    
//---METHODS---//
    
    //Load Image Array
    public PImage[] loadSpritesheets(String fileName, Player p) {

        totalImages = 55;
        imageArray = new PImage[totalImages];

        print("\nDirectory: ", playerSpriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = playerSpriteSheetDirectory + "\\" + fileName;
        print("\nPath:", path);
        
        print("\nLOADING IMAGES\n");
        for (int i = 0; i < totalImages;i++) {
            imageArray[i] = loadImage(path + nf(i,2) + ".png");
            print(path + nf(i,2) + ".png\n"); 
        }
        
        print("\nImage Array: ");
        for (int i = 0; i < imageArray.length; i++) {
            print("\n", "[",i,"]", imageArray[i]);
        }
        
        totalImages = 0;
        return imageArray;
        
    }

    //Load Level Image Array
    public PImage[] loadSpritesheets(String fileName, Level l) {

        totalImages = 9;
        imageArray = new PImage[totalImages];
        print("/n-----------I am in use---------------");

        print("\nDirectory: ", levelSpriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = levelSpriteSheetDirectory + "\\" + fileName;
        print("\nPath:", path);
        
        print("\nLOADING IMAGES\n");
        for (int i = 0; i < totalImages;i++) {
            imageArray[i] = loadImage(path + nf(i,2) + ".png");
            print(path + nf(i,2) + ".png\n"); 
        }
        
        print("\nImage Array: ");
        for (int i = 0; i < imageArray.length; i++) {
            print("\n", "[",i,"]", imageArray[i]);
        }
        totalImages = 0;
        return imageArray;
        
    }

    //Load Enemy Image Array
    public PImage[] loadSpritesheets(String fileName, Enemy e) {

        totalImages = 53;
        imageArray = new PImage[totalImages];
        print("/n-----------I am in use---------------");

        print("\nDirectory: ", enemySpriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = enemySpriteSheetDirectory + "\\" + fileName;
        print("\nPath:", path);
        
        print("\nLOADING IMAGES\n");
        for (int i = 0; i < totalImages;i++) {
            imageArray[i] = loadImage(path + nf(i,2) + ".png");
            print(path + nf(i,2) + ".png\n"); 
        }
        
        print("\nImage Array: ");
        for (int i = 0; i < imageArray.length; i++) {
            print("\n", "[",i,"]", imageArray[i]);
        }
        totalImages = 0;
        return imageArray;   
    }

    //Load EnemyRanged Image Array
    public PImage[] loadSpritesheets(String fileName, EnemyRanged e) {

        totalImages = 53;
        imageArray = new PImage[totalImages];
        print("/n-----------I am in use---------------");

        print("\nDirectory: ", enemyRangedSpriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = enemyRangedSpriteSheetDirectory + "\\" + fileName;
        print("\nPath:", path);
        
        print("\nLOADING IMAGES\n");
        for (int i = 0; i < totalImages;i++) {
            imageArray[i] = loadImage(path + nf(i,2) + ".png");
            print(path + nf(i,2) + ".png\n"); 
        }
        
        print("\nImage Array: ");
        for (int i = 0; i < imageArray.length; i++) {
            print("\n", "[",i,"]", imageArray[i]);
        }
        totalImages = 0;
        return imageArray;
    }

    //getters
    public int getNumofImagesInArray(PImage[] imageArray) {
        return imageArray.length;
    }

  
    
    
    
}
