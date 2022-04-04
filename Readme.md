# Readme

Name : Matthew Hornby

Student Number: 20058053

## Brief description of the game developed 1/2 sentences

Game Name: Block Fighter

Description: Player must kill enemies and avoid blocks falling from the sky

## Known bugs/problems

## Keystrokes/Mouse

| Action     | Button   |
| ---------- | -------- |
| Debug Menu | Ctrl + D |

## Sources / References

| Source                                                                                  | Purpose                                               |
| --------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| ReNamer                                                                                 | Tool to bulk rename files, used on the sprite sheets. |
| <https://processing.org/reference/ArrayList.html>                                         | ArrayList syntax and methods                          |
| <https://www.programiz.com/java-programming/examples/pass-arraylist-as-function-argument> | How do I pass an Array List as a Parameter            |

### Spritesheets

| Sprite                                                        | Purpose        |
| ------------------------------------------------------------- | -------------- |
| <https://opengameart.org/content/hero-spritesheets-ars-notoria> | Main Character |

## TODO

### Code

- [ ] Further break down the SpriteSheet image Array so that there are points for different elements. For Example:
  - Main Character is playerImages[0] - playerImages[18]. Would like to reference this part of the array using a SpriteSheet(mainCharacter) - this is only relevant for the debugger right now.
  - Could add different arrays completely for different actors - this defeats the purpose of the image loader though

### Music

- [ ] Find Music Files:
  - [ ] Background Music Loop
  - [ ] Special Background Music Loop (low health or boss fight)
  - [ ] Player
    - [ ] Attack 1
    - [ ] Spell 1
    - [ ] Walking
    - [ ] Death
    - [ ] Jumping
  - [ ] Enemy
    - [ ] Attack 1
    - [ ] Walking
    - [ ] Death
    - [ ] Greeting
  
- [ ] Extend or Duplicate loadSpritesheets(String directory) so that I can load Music Files

### Player

- [ ] Controller
- [ ] Movement
- [ ] Death
- [ ] Collision
- [ ] Take Damage
- [ ] Move display() into update ()

### Game

- [ ] Score
- [ ] Win Condition
- [ ] Lose Condition
- [ ] Block Falling
- [ ] Difficulty Modifier - take input

### Enemy

- [ ] Enemy Class
- [ ] Sprite
- [ ] Animations
  - [ ] Walk
  - [ ] Attack
  - [ ] Death

### Art

- [ ] Background
- [ ] Ambience
