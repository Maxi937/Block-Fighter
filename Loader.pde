class Loader {
    
//---PROPERTIES---//
    private int totalImages;
    PImage[] imageArray;
    String path;
    
    
//---CONSTRUCTOR---//
    
    Loader() {
        totalImages = 0;
        
    }
    
//---METHODS---//
    
    //Load Image Array
    public PImage[] loadSpritesheets(String spriteSheetDirectory, String fileName, Player p) {

        totalImages = 53;
        imageArray = new PImage[totalImages];

        print("\nDirectory: ", spriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = spriteSheetDirectory + "\\" + fileName;
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
    public PImage[] loadSpritesheets(String spriteSheetDirectory, String fileName, Level l) {

        totalImages = 9;
        imageArray = new PImage[totalImages];
        print("/n-----------I am in use---------------");

        print("\nDirectory: ", spriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = spriteSheetDirectory + "\\" + fileName;
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
    public PImage[] loadSpritesheets(String spriteSheetDirectory, String fileName, Enemy e) {

        totalImages = 53;
        imageArray = new PImage[totalImages];
        print("/n-----------I am in use---------------");

        print("\nDirectory: ", spriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = spriteSheetDirectory + "\\" + fileName;
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
    public PImage[] loadSpritesheets(String spriteSheetDirectory, String fileName, EnemyRanged e) {

        totalImages = 53;
        imageArray = new PImage[totalImages];
        print("/n-----------I am in use---------------");

        print("\nDirectory: ", spriteSheetDirectory);
        print("\nTotal number of images: ",totalImages,"\n");
        path = spriteSheetDirectory + "\\" + fileName;
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

    //setters
  
    
    
    
}
