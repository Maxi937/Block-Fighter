class Game {
    
    //---PROPERTIES---//
    
    //arrays
    PImage[] playerImages;
    
    //asset filepaths
    String playerSpriteSheetDirectory;
    String enemySpriteSheetDirectory;
    String bulletSpriteSheetDirectory;
    String birdSpriteSheetDirectory;
    

    //---CONSTRUCTOR---//

    Game() {
        //Set FilePaths
        playerSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\MainCharacter\\";
        enemySpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Enemy\\";
        bulletSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bullet\\";
        birdSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bird\\";

        playerImages = new PImage[0];
    }
    
    //---METHODS---//
    
    //called once on Setup()
    private void loadGame() {

        //create Player Object
        p = new Player();

        //create Loader Object
        l = new Loader();
        playerImages = l.loadSpritesheets(playerSpriteSheetDirectory, playerImages);
        l.setImageArray(playerImages);

        //create Enemy Object
        enemy = new Enemy();

        //create Level Object
        level = new Level();

        //create Level Loader
        //l = new Loader()
        //levelImages = l.loadSpritesheets(playerSpriteSheetDirectory, levelImages);

    }
    
    //called every frame on Draw()
    private void updateGame() {
        //update Level
        level.display();

        //update Player
        p.hitboxcolour(0,0,255,50);
        p.update();
        p.display();

        //update Enemy
        enemy.hitboxcolour(255,0,0,50);
        enemy.update();
        enemy.display();
    }
}
    
