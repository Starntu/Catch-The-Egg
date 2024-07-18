function love.load()
    -- The title of my game
    love.window.setTitle("Catch The Egg!")
    
    --The background image
    background = love.graphics.newImage("Images/Papel de Parede _ Páscoa.png")

    -- The music
    music = love.audio.newSource("Music/The Entertainer.mp3", "stream")
    music:setLooping(true)
    music:setVolume(0.5)

    -- Get my bucket drawing/sprite
    bucket = love.graphics.newImage("Sprites/Egg Basket.png")

    -- Set the original coordiantes for my bucket and the limits
    bucketX = 300
    bucketY = 430
    maxBucketX = 600
    minBucketX = 30

    -- The x and y value of the ellipse / my egg, the radius, and the inital position
    eggX = 100
    eggY = 100
    eggRadius = 7.5
    eggSpawnY = -50

    -- Keep track of the points
    points = 0

    -- Set gameover to false
    gameover = false

    -- Keep track of the current level
    currentLevel = 1

    -- Set gameStarted to false
    gameStarted = false
end

function love.update(dt)
    -- If the game hasn't started yet, then nothing should be updated yet
    if not gameStarted then
        return
    end

    -- Play the music except when the player has won or lost
    if gameStarted and not music:isPlaying() then
        music:play()
    end

    if currentLevel == 4 or currentLevel == 5 then
        music:stop()
    end

    -- Gameover should be set to true if its not already, the Y value of the egg exceeds the screen, and its not the win screen displayed (currentLevel doesnt equal 5)
    if not gameover and eggY > windowHeight and currentLevel ~= 5 then
        gameover = true
    end

    -- Allow the user to determine the left to right direction of the bucket
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        bucketX = bucketX - 5
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        bucketX = bucketX + 5
    end

    -- Check if the bucket is too much to the right
    if bucketX > maxBucketX then
        bucketX = maxBucketX
    end

    -- Check if the bucket is too much to the left
    if bucketX < minBucketX then
        bucketX = minBucketX
    end

    -- Update the fall speed based on the currentLevel
    fallSpeed = 2
    if currentLevel == 1 then
        fallSpeed = 5
    elseif currentLevel == 2 then
        fallSpeed = 8
    elseif currentLevel == 3 then
        fallSpeed = 10
    end

    -- Have the egg fall
    eggY = eggY + fallSpeed

    -- Change the level based on the points
    if points == 10 then
        currentLevel = 2
    elseif points == 30 then
        currentLevel = 3
    elseif points < 10 then
        currentLevel = 1
    end

    -- Check for a collision, add a point if there is and spawn a new random egg
    if Collision(100, eggY, eggRadius, bucketX, bucketY, bucket:getWidth(), bucket:getHeight()) then
        points = points + 1
        RandomEgg()
    end

    -- To make sure that the gameover screen doesn't come after the win screen, set them to true based on the level
    if gameover then
        currentLevel = 4
    end

    if points == 50 then
        currentLevel = 5
    end
end

function love.draw()
    -- There should be a screen before the game starts to explain the rules.
    if not gameStarted then
        -- Get the width and height of the screen
        windowWidth = love.graphics.getWidth()
        windowHeight = love.graphics.getHeight()

        -- Instructions
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.printf("Catch The Egg!", 0, 100, windowWidth, "center")

        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.printf("Instructions:\n", 0, 200, windowWidth, "center")
        love.graphics.printf("- Move the basket using the 'A' and 'D' keys or the left and right arrow keys.\n", 0, 230, windowWidth, "center")
        love.graphics.printf("- Catch as many eggs as possible to earn points.\n", 0, 260, windowWidth, "center")
        love.graphics.printf("- Avoid letting the eggs fall off the screen.\n", 0, 290, windowWidth, "center")
        love.graphics.printf("- Reach 40 points to win the game. Remember, there are 3 levels and each level is harder than the last.\n", 0, 320, windowWidth, "center")

        -- The start button
        love.graphics.setColor(0.2, 0.6, 0.2)
        startButtonX = (windowWidth - 200) / 2
        love.graphics.rectangle("fill", startButtonX, 400, 200, 60)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.printf("Start", startButtonX, 420, 200, "center")
    else
        -- Draw the gameover screen if its set to true
        if currentLevel == 4 then
            love.graphics.setFont(love.graphics.newFont(36))
            love.graphics.print("GAME OVER! :(", 250, 250)
            love.graphics.setFont(love.graphics.newFont(24))
            love.graphics.print("Press 'R' to restart", 250, 350)
            return
        end

        -- Draw the end / win screen
        if currentLevel == 5 then
            love.graphics.setFont(love.graphics.newFont(36))
            love.graphics.printf("YOU WON! :)", 0, 100, windowWidth, "center")

            love.graphics.setFont(love.graphics.newFont(24))
            love.graphics.printf("Press 'R' to restart", 0, 150, windowWidth, "center")

            love.graphics.setFont(love.graphics.newFont(20))
            love.graphics.printf("Created By: Faith Adewole", 0, 220, windowWidth, "center")
            love.graphics.printf("Thank you for playing my CS50 Final Project, 'Catch The Egg!', I hope you enjoyed.", 0, 250, windowWidth, "center")

            love.graphics.setFont(love.graphics.newFont(15))
            love.graphics.printf("Credits:", 0, 400, windowWidth, "center")
            love.graphics.printf("Background from Thalita Alves at Pinterest at @althalita_", 0, 430, windowWidth, "center")

            love.graphics.printf("Music Credits:", 0, 490, windowWidth, "center")
            love.graphics.printf("'The Entertainer' Kevin MacLeod (incompetech.com)", 0, 520, windowWidth, "center")
            love.graphics.printf("Licensed under Creative Commons: By Attribution 4.0 License", 0, 550, windowWidth, "center")
            love.graphics.printf("http://creativecommons.org/licenses/by/4.0/", 0, 580, windowWidth, "center")
            return
        end

        --Get the width and height of the background
        backgroundWidth = background:getWidth()
        backgroundHeight = background:getHeight()

        -- Scale the background by dividing the dimensions of the screen to the dimenstions of the original background
        scaleX = windowWidth / backgroundWidth
        scaleY = windowHeight / backgroundHeight

        -- Draw background
        love.graphics.draw(background, scaleX, scaleY)

        -- Draw my bucket
        love.graphics.draw(bucket, bucketX, bucketY)

        -- Draw an egg
        love.graphics.ellipse("fill", eggX, eggY, 10, 15)

        -- Draw the number of points on the top left hand corner
        love.graphics.setFont(love.graphics.newFont(36))
        love.graphics.print("Points: " .. points, 10, 10)

        -- Draw the level the user is on on the top right hand corner
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.print("Level: " .. currentLevel, windowWidth - 150, 10)
    end
end

-- A function to start the game when the start button is clicked
function love.mousepressed(x, y, button, istouch, presses)
    if not gameStarted and button == 1 then
        startButtonWidth = 200
        startButtonHeight = 60
        startButtonX = (windowWidth - startButtonWidth) / 2
        startButtonY = 400

        if x >= startButtonX and x <= startButtonX + startButtonWidth and y >= startButtonY and y <= startButtonY + startButtonHeight then
            gameStarted = true
        end
    end
end

-- A function to check for a collision
-- First it checks if the eggs x is within the bounds of the baskets x . 
-- Then if the eggs y (specifically the bottom) is at or below the baskets y
function Collision(ex, ey, er, spriteX, spriteY, spriteWidth, spriteHeight)
    if eggX + er >= spriteX and eggX - er <= spriteX + spriteWidth then
        return eggY + er >= spriteY
    end
    return false
end

-- A function to spawn random eggs
function RandomEgg()
    eggX = love.math.random(minBucketX + eggRadius * 2, maxBucketX - eggRadius * 2)
    eggY = eggSpawnY
end

-- A function to restart the game if r is pressed by reseting points to 0 and setting gameover to false
function love.keypressed(key)
    if key == "r" then
        points = 0
        RandomEgg()
        gameover = false
    end
end