class Loader {
    
    //---PROPERTIES---//
    private String[] nameAssetFolders;
    private int numofAssetFolders;
    private int totalImages;
    
    
    
    
    //---CONSTRUCTOR---//
    
    Loader() {
        totalImages = 0;
    }
    
    //---METHODS---//
    
    //Load Image Array
    public PImage[] loadSpritesheets(String spriteSheetDirectory, PImage[] imageArray) {
        /*
        This method takes in a Directory & an Array.
        finds the number of folders in the Directory.
        Finds the number of files in each folder.
        Adds every file to the Array returns the array.
        This Array will be referenced later to display animations for game elements.
        The frames inside each folder must have the same name as the folder they are in with the frame suffix. 
        */
        
        print("\nDirectory: ", spriteSheetDirectory);
        
        numofAssetFolders = getNumOfFiles(spriteSheetDirectory);
        nameAssetFolders = getNameAssetFolders(spriteSheetDirectory);
        
        //print("\nNumber of Asset Folders: ", numofAssetFolders);
        for (int i = 0; i < numofAssetFolders; i++) {
            print("\nAsset Folders: ", nameAssetFolders[i]);
        }
        
        //print("\n\nFile Manifest:");
        for (int i = 0; i < numofAssetFolders; i++) {
            totalImages = totalImages + getNumOfFiles(spriteSheetDirectory + nameAssetFolders[i]);
            printlistoffilestoconsole(spriteSheetDirectory + nameAssetFolders[i]);
        }
        
        print("\nTotal number of images: ",totalImages,"\n");
        
        
        for (int i = 0; i < numofAssetFolders; i++) {
            print("\nFolder: ",nameAssetFolders[i], "\nNumber of files to load:" + getNumOfFiles(spriteSheetDirectory + nameAssetFolders[i]));
            imageArray = loadAssets(imageArray,spriteSheetDirectory + nameAssetFolders[i], getNumOfFiles(spriteSheetDirectory + nameAssetFolders[i]));
        }
        
        print("\nImage Array: ");
        for (int i = 0; i < imageArray.length; i++) {
            print("\n", "[",i,"]", imageArray[i]);
        }
        return imageArray;
    }
    
    private PImage[] loadAssets(PImage[] imageArray, String path, int numimagestoload) {
        print("\n\nNUM IMAGES TO LOAD:", numimagestoload);
        
        path = path + "\\" + path.substring(path.lastIndexOf("\\") + 1);
        
        print("\nLOADING IMAGES\n");
        for (int i = 0; i < numimagestoload;i++) {
            imageArray = (PImage[])append(imageArray, loadImage(path + nf(i,2) + ".png"));
            print(path + nf(i,2) + ".png\n");
        } 
        
        return imageArray;
    }
    
    
    private int getNumOfFiles(String pathtofolder) {
        String[] files;
        File f = new File(pathtofolder);
        files = f.list();
        
        return int(files.length);
    }
    
    private void printlistoffilestoconsole(String pathtofolder)
        {
        String[] files;
        File f = new File(pathtofolder);
        files = f.list();
        
        for (int i = 0;i < files.length; i++) {
            print("\n", files[i]);
        }
    }
    
    private String[] getNameAssetFolders(String pathtofolder)
        {
        String[] files;
        File f = new File(pathtofolder);
        files = f.list();
        return files;
    }
    
    //getters
    public int getNumofImagesInArray(PImage[] imageArray) {
        return imageArray.length;
    }
    
    //setters
    public void setImageArray(PImage[] imageArray) {
        p.playerImages = imageArray;
    }
    
    
    
}
