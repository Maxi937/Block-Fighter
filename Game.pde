class Game {
    
//---PROPERTIES---//
    int score;
    String name;

    //asset filepaths
    String playerSpriteSheetDirectory;
    String enemySpriteSheetDirectory;
    String bulletSpriteSheetDirectory;
    String birdSpriteSheetDirectory;
    String levelSpriteSheetDirectory;
    String effectSpriteSheetDirectory;
    
    //arrays
    PImage[] playerImages;
    PImage[] enemyImages;
    PImage[] levelImages;
    PImage[] effectImages;
 
    

//---CONSTRUCTOR---//

    Game() {
        //Set FilePaths
        playerSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Player\\";
        enemySpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Enemy\\";
        bulletSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bullet\\";
        birdSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bird\\";
        levelSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Level\\";
   
        playerImages = new PImage[0];
        enemyImages = new PImage[0];

        score = 0;
    }
    
//---METHODS---//
    
    //called once on Setup()
    private void loadGame() {

        //create Loader Object
        l = new Loader();

        //create Level Object
        level = new Level();
        levelImages = l.loadSpritesheets(levelSpriteSheetDirectory, "level", level);
        level.setImageArray(levelImages);

        //create Player Object
        p = new Player();
        playerImages = l.loadSpritesheets(playerSpriteSheetDirectory, "player", p);
        p.setImageArray(playerImages);
    
        //create Enemy Object
        enemy = new Enemy();
        enemyImages = l.loadSpritesheets(playerSpriteSheetDirectory, "player", enemy);
        enemy.setImageArray(enemyImages);
        

        //create Ranged Enemy Object
        enemyRanged = new EnemyRanged();
        enemyImages = l.loadSpritesheets(playerSpriteSheetDirectory, "player", enemyRanged);
        enemyRanged.setImageArray(enemyImages);

        //create Bullet Object
        bullet = new Bullet();

        //create Collision Object
        c = new CollisionDetector();
    }
    
    //called every frame on Draw()
    private void updateGame() {
        //update Level
        level.update();

        //update Player
        p.setHitBoxColour(0,0,255,50);
        p.update();

        //update Enemy
        enemy.setHitBoxColour(255,0,0,50);
        if (enemy.getDeath() == false){
                enemy.update();
                c.getHit(p,enemy);
            }


        //update Enemy
        enemyRanged.setHitBoxColour(255,0,0,50);
        if (enemyRanged.getDeath() == false){
                enemyRanged.update();
                c.getHit(p, enemyRanged);
                c.getHit(bullet, p);
            }
        bullet.update();

        //update Collision Detector
        print("\nScore:", score);
    }


    //getters
    public int getScore(){
        return score;
    }


    //setters
    public void setScore(int s){
        score = score + s;
    }
}
    
