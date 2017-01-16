
-- Lets Play With the ball
--We can even change the way the touch works
-- Now if you touch right bottom of the screen the ball moves right
-- We can alter it and make the game more entertaining
-- when player presses right we can alter code and move the ball to left and vice versa

-- Now its in Normal Mode !!

local i


Random = math.random

local physics = require("physics")
physics.start()
physics.setDrawMode("normal")
physics.setGravity(0,0)

 numBalloons=10
 numbullet=100



-- Screen Measuring
w=display.contentWidth
h=display.contentHeight

local startButtonListeners = {}
local showCredits = {}
local showrsn={}

local hidersn={}
local hideCredits = {}
local showGameView = {}
local gameListeners = {}



-- Background
local background = display.newImage("bckgrnd.png")
display.setStatusBar(display.HiddenStatusBar)


--Two lines on the both sides

local rect = display.newImage("rect1.png")
rect.width=200
rect.height=600
rect.x=160
rect.y=220
--[[
local rect2 = display.newImage("rect2.png")
rect2.width=200
rect2.height=600
rect2.x=160
rect2.y=-280
]]--
local bottom = display.newLine(59,h+43,w-59,h+43)
bottom.width=2
bottom:setColor(1,1,0)



local line1 = display.newRect(60,-45,60,h*2+190)
line1.width=4
line1:setFillColor(0.3,0.1,0.9)
local line2 = display.newRect(w-60,-47,w-60,h*2+190)
line2.width=4
line2:setFillColor(0.3,0.1,0.9)
local linea = display.newRect(125,-45,125,h*2+190)
linea.width=4
linea:setFillColor(0,1,0)
local lineb = display.newRect(w-128,-47,w-128,h*2+190)
lineb.width=4
lineb:setFillColor(0,1,0)

--local circle = display.newCircle(90,90,20)
--local rr = display.newRoundedRect(100,100,90,90,30)

local ball = display.newImageRect("ball.png",60,60)
ball.alpha= 1  --opacity
ball.x=158  -- 83
ball.y=360
ball.myName = "ball"


--Left Right Saarne ...
local left = display.newImageRect("left.png",65,65)
left.width=200
left.height=290
left.x=80
left.y=h-49
left.alpha=0.01

local right = display.newImageRect("right.png",65,65)
right.width=200
right.height=290
right.x=w-46
right.y=h-49
right.alpha=0.01




function Main()
playBtn = display.newImage("playBtn.png", 150, 199)
playBtn.width=60
playBtn.height=60
creditsBtn = display.newImage("creditsBtn.png", 160, 260)
creditsBtn.width=180
codedbyBtn = display.newImage("codeby.png",160,500)
codedbyBtn.width=180

titleView = display.newGroup(playBtn, creditsBtn,codedbyBtn)
startButtonListeners("add")
end

--. Start Button Listeners
--The following function adds the necessary listeners to the TitleView's buttons.

function startButtonListeners(action)
  if(action == "add") then
    playBtn:addEventListener("tap", showGameView)
    creditsBtn:addEventListener("tap", showCredits)
    codedbyBtn:addEventListener("tap",showrsn)

  else
    playBtn:removeEventListener("tap", showGameView)
    creditsBtn:removeEventListener("tap", showCredits)
    codedbyBtn:removeEventListener("tap",showrsn)

  end
end



--he credits screen is shown when the user taps the about button. A tap listener is added to the credits view to dismiss it when the user taps it.
function showrsn : tap (e)
playBtn.isVisible = false
creditsBtn.isVisible=false
codedbyBtn.isVisible=false
coder = display.newImage("rsn.png",-50, display.contentHeight-180)
transition.to(coder,{time = 300 , x =158,onComplete = function()coder : addEventListener("tap", hidersn)end})
end

function hidersn : tap (e)
playBtn.isVisible = true
creditsBtn.isVisible=true
codedbyBtn.isVisible=true
transition.to(coder,{time = 900 , y = -200 ,  onComplete = function() coder:removeEventListener("tap", hidersn) display.remove(coder) coder = nil end})
end

function showCredits:tap(e)
  playBtn.isVisible = false
  creditsBtn.isVisible = false
  creditsView = display.newImage("credits.png", -50, display.contentHeight-180)
  transition.to(creditsView, {time = 300, x = 158, onComplete = function() creditsView:addEventListener("tap", hideCredits) end})
end
-- HIDE CREDIts
--When the user taps the credits view, it is animated out of the stage and remove.

function hideCredits:tap(e)
  playBtn.isVisible = true
  creditsBtn.isVisible = true
  transition.to(creditsView, {time = 300, y = display.contentHeight+creditsView.height, onComplete = function() creditsView:removeEventListener("tap", hideCredits) display.remove(creditsView) creditsView = nil end})
end


function showGameView:tap(e)
  transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners("rmv") display.remove(titleView) titleView = nil end})


-- Instructions
ins = display.newImage("ins.png", 158, 250)
  transition.from(ins, {time = 800, alpha = 0.1, onComplete = function() timer.performWithDelay(2000, function() transition.to(ins, {time = 200, alpha = 0.1, onComplete = function() display.remove(ins) ins = nil end}) end) end})
end




-- Left right button touch sensor
function left : touch(event)

if (event.phase=="began") then
--transition.to(ball,{x=83,y=ball.y,speed=2000})
if (ball.x == 158) then
transition.to(ball,{x=92,y=ball.y,speed=2000})

end
if (ball.x == 227) then
transition.to(ball,{x=158,y=ball.y,speed=2000})
end
end
end
left:addEventListener("touch",left)

--Right movement
function right : touch(event)
if (event.phase=="began") then
if (ball.x == 158 ) then
--transition.to(ball,{x=156+83,y=ball.y,speed=2000})
transition.to(ball,{x=227,y=ball.y,speed=2000})
end
if (ball.x == 92 ) then
transition.to(ball,{x=158,y=ball.y,speed=2000})
end
end
end
right:addEventListener("touch",right)



-- Calling Main Function
Main()


-- SOUND HHAAHHAHA
local sound = media.newEventSound("whrugo.wav")
--media.playEventSound(sound)

-- VIDEO hahaha





physics.addBody(ball,"static",{bounce=0.8,radius = 25})
--physics.addBody(rect,"kinetic",{friction=00,speed=3000})
physics.addBody(bottom,"static",{bounce=01})
physics.addBody(line1,"static",{bounce=0.6})
physics.addBody(line2,"static",{bounce=0.6})
physics.addBody(linea,"static",{bounce=0.6})
physics.addBody(lineb,"static",{bounce=0.6})
--physics.addBody(bullet,"static",{radius=6,bounce=0.6})

local function startGame()
balloon = display.newImageRect("balloon.png",25,25)

            background.anchorX=0.1
            background.anchorY=0.04

           -- Generate balloons randmly on x axis
            balloon.x = Random(93,93)

            -- Generate balloons 10 pixels off screen on y axis
        --balloon.y = Random(1,9)
        physics.pause()
        physics.addBody(balloon,"static",{density=0.1,friction=0.1,bounce=0.6,radius=10})
        transition.to(balloon,{  y = h , time = 10000})


end


gameTimer = timer.performWithDelay(910,startGame,numBalloons)

local function firing()
local bullet = display.newImage("bullet.png")
bullet.x=ball.x
bullet.y=ball.y
physics.addBody(bullet,"dynamic",{density = 0.1 , friction = 0.1,radius=3})
transition.to(bullet,{x=ball.x , y= -70 , speed = 10000})
end
firetimer = timer.performWithDelay(440,firing,numbullet)

-- Collision Function
local function onCollision (event)
if ( event.phase == "began") then

display.remove(balloon)
end
end
Runtime : addEventListener("collision",onCollision)



