########################### Radial Menu Script ##############################
########## VERSION 2.2 for Essentials v20
########## CREDITS: Yankas  Original script for v17
##########          Cony    Compatibility for v19
##########          Hallow  Compatibility for v20
#####################################################################################

#######
####### ICONS FOR THE MENU'S ENTRIES
#######
ICON_POKEMON = "Plugins/Radial Menu/Icons/itemRM1"
ICON_MAP = "Plugins/Radial Menu/Icons/itemRM2"
ICON_POKEDEX = "Plugins/Radial Menu/Icons/itemRM3"
ICON_BAG = "Plugins/Radial Menu/Icons/itemRM4"
ICON_POKEGEAR = "Plugins/Radial Menu/Icons/itemRM5"
ICON_TRAINER = "Plugins/Radial Menu/Icons/itemRMT"
ICON_OPTIONS = "Plugins/Radial Menu/Icons/itemRMO"
ICON_DEBUG = "Plugins/Radial Menu/Icons/itemRMD"
ICON_SAVE = "Plugins/Radial Menu/Icons/itemRMS"
ICON_EXIT = "Plugins/Radial Menu/Icons/itemRMB"
ICON_BOXES = "Plugins/Radial Menu/Icons/itemRM6"

#######
####### APPEARANCE
#######
# Distance of menu icons from the center / player character
MENU_DISTANCE = 110
ICON_WIDTH = 50 # The width of the menu icon FILE ### NOT TESTED
ICON_HEIGHT = 50 # The height of menu icon FILE ### NOT TESTED
ACTIVE_SCALE = 1.5 # Resize factor of the currently active icon.
ACTIVE_OPACITY = 255 # Transparency of active icon; 0=fully transparent, 255=fully solid
ACTIVE_TONE = Tone.new(0,0,0,0) # Tone (Red, Green, Blue, Grey) shift applied to active icon.
INACTIVE_OPACITY = 160 # Transparency of inactive icons; 0=fully, 255=fully solid
INACTIVE_TONE = Tone.new(0,0,0,0) # Tone (Red, Green, Blue, Grey) shift applied to inactive icon.
MENU_TEXTCOLOR=Color.new(244,244,244) # The text color of the menu icon's name/description.
MENU_TEXTOUTLINE=Color.new(30,30,30) # The highlight (outline) color of the text.
MENU_OPEN_SOUND = "GUI menu open" # When menu opens, play the following sound.
BACKGROUND_TINT = Tone.new(0,0,0,150) # Tone (Red, Green, Blue, Grey) applied to the background/map.

#######
####### BEHAVIOR
#######
# Determines the position of the "active/selected" item. You can set
# any angle you like (in Radians), or use one of the 4 presets here.
# TOP (default)		= -(Math::PI/2)
# RIGHT 			= 0
# LEFT				= Math::PI
# BOTTOM			= Math::PI/2
BASE_ANGLE = -(Math::PI/2)
FORCE_PLAYER_LOOK_DOWN = false # Option to look the player to face downwards during the menu.
BUTTON_COUNTERCLOCKWISE = Input::LEFT # Button used to turn the menu counterclockwise, default=Input::Left
BUTTON_CLOCKWISE = Input::RIGHT # Button used to turn the menu clockwise, default=Input::Right

#######
######## ANIMATIONS
#######
# How long the animation for changing menu selection lasts in frames. (20 frames = 1 second); 1 = instant
# DO NOT SET TO 0 OR LESS
ANIM_TURN_LENGTH = 8
# How long the animation for changing entries takes frames. (20 frames = 1 second); 1 = instant
# DO NOT SET TO 0 OR LESS
ANIM_START_LENGTH = 6
# The Sound used when changing your selection in the menu, don't add file extension.
ANIM_TURN_SOUND = "GUI sel cursor"

#######
######## CLOCK
#######
# Set to false to disable the clock.
ENABLE_CLOCK = true # enable the clock, for clock configuration, CTRL+F: "class Clock"
# Determines the way time is displayed.
# Substitute with any valid formatting code
# FORMAT 		=> EXAMPLE ######
# "%I:%M %p" 		=> 07:08 pm
# "%I:%M:%S %p" 	=> 07:08:20 pm
# "%H:%M:%S"		=> 19:08:20
# "%H:%M			=> 19:08
CLOCK_TIME_FORMAT = "%I:%M %p"
# Color of the clock's text
CLOCK_TEXTCOLOR = Color.new(244,244,244)
# Color of the clock's text outline
CLOCK_HIGHLIGHTCOLOR = Color.new(30,30,30)


#####################################################################################

class MenuEntry
	attr_accessor :angle
	attr_reader :name
	attr_reader :icon
end

class MenuEntryPokemon < MenuEntry
	def initialize
		@icon = ICON_POKEMON
		@name = "Pokémon"
	end
	def selected(menu)
		hiddenmove = nil
    pbFadeOutIn {
      sscene = PokemonParty_Scene.new
      sscreen = PokemonPartyScreen.new(sscene,$player.party)
      hiddenmove = sscreen.pbPokemonScreen
    }
    if hiddenmove
      $game_temp.in_menu = false
      pbUseHiddenMove(hiddenmove[0],hiddenmove[1])
      return
    end
  end
end

class MenuEntryPokedex < MenuEntry
	def initialize
		@icon = ICON_POKEDEX
		@name = "Pokédex"
	end
	def selected(menu)
    if $player.pokedex.accessible_dexes.length == 1
      $PokemonGlobal.pokedexDex = $player.pokedex.accessible_dexes[0]
      pbFadeOutIn {
        scene = PokemonPokedex_Scene.new
        screen = PokemonPokedexScreen.new(scene)
        screen.pbStartScreen
      }
    else
      pbFadeOutIn {
        scene = PokemonPokedexMenu_Scene.new
        screen = PokemonPokedexMenuScreen.new(scene)
        screen.pbStartScreen
      }
    end
  end
end

class MenuEntryBag < MenuEntry
	def initialize
		@icon = ICON_BAG
		@name = "Bag"
	end
	def selected(menu)
        item = nil
        pbFadeOutIn {
            scene = PokemonBag_Scene.new
            screen = PokemonBagScreen.new(scene,$bag)
            item = screen.pbStartScreen
        return (item)
        }
        if item
            $game_temp.in_menu = false
            pbUseKeyItemInField(item)
            return true
        end
	end
end

class MenuEntryPokegear < MenuEntry
	def initialize
		@icon = ICON_POKEGEAR
		@name = "PokéGear"
	end
	def selected(menu)
    pbFadeOutIn {
    	scene = PokemonPokegear_Scene.new
        screen = PokemonPokegearScreen.new(scene)
        screen.pbStartScreen
	}
	end
end

class MenuEntryTrainer < MenuEntry
	def initialize
		@icon = ICON_TRAINER
		@name = $Trainer.name
	end
	def selected(menu)
    pbFadeOutIn {
      scene = PokemonTrainerCard_Scene.new
      screen = PokemonTrainerCardScreen.new(scene)
      screen.pbStartScreen
    }
	end
end

class MenuEntrySave < MenuEntry
	def initialize
		@icon = ICON_SAVE
		@name = "Save"
	end
  def selected(menu)
    scene = PokemonSave_Scene.new
    screen = PokemonSaveScreen.new(scene)
    if screen.pbSaveScreen
      endscene = false
    end
  end
end

class MenuEntryMap < MenuEntry
	def initialize
		@icon = ICON_MAP
		@name = "Map"
	end
	def selected(menu)
        pbShowMap(-1,false)
	end
end

class MenuEntryOptions < MenuEntry
	def initialize
		@icon = ICON_OPTIONS
		@name = "Options"
	end
	def selected(menu)
    pbFadeOutIn {
      scene = PokemonOption_Scene.new
      screen = PokemonOptionScreen.new(scene)
      screen.pbStartScreen
      pbUpdateSceneMap
		}
	end
end

class MenuEntryDebug < MenuEntry
	def initialize
		@icon = ICON_DEBUG
		@name = "Debug"
	end
	def selected(menu)
    pbFadeOutIn {
      pbDebugMenu
    }
	end
end

class MenuEntryExitSafari < MenuEntry
	def initialize
		@icon = ICON_EXIT
		@name = "Quit Safari"
	end
	def selected(menu)
		if pbInSafari?
      if pbConfirmMessage(_INTL("Would you like to leave the Safari Game right now?"))
				menu.pbEndScene
				pbSafariState.decision = 1
				pbSafariState.pbGoToStart
        return false
			end
    return false # Since we already exited the scene, we shouldn't return an exit command.
		end
	end
end

class MenuEntryExitBugContest < MenuEntry
	def initialize
		@icon = ICON_EXIT
		@name = "Quit Contest"
	end
	def selected(menu)
		if pbInBugContest?
			if pbConfirmMessage(_INTL("Would you like to end the Contest now?"))
				menu.pbEndScene
				pbBugContestState.pbStartJudging
			end
			return false # Since we already exited the scene, we shouldn't return an exit command.
		end
	end
end

class MenuEntryBoxes < MenuEntry
	def initialize
		@icon = ICON_BOXES
		@name = "Boxes"
	end
	def selected(menu)
    pbFadeOutIn {
      scene = PokemonStorageScene.new
      screen = PokemonStorageScreen.new(scene, $PokemonStorage)
      screen.pbStartScreen(0)
    }
	end
end

class MenuEntryQuests < MenuEntry
  def initialize
    @icon = ICON_DEBUG
    @name = "Quests"
  end

  def selected(menu); pbFadeOutIn(99999) { pbViewQuests }; end
end

class Component
	attr_accessor :viewport
	attr_accessor :sprites

	def initialize(viewport, spritehash)
		@viewport = viewport
		@sprites = spritehash
	end

	def dispose
		@sprites = nil
	end
end

class Clock < Component
	def initialize(viewport, spritehash, format)
		super(viewport, spritehash)
		@time = pbGetTimeNow
		@sprites["clock"] = BitmapSprite.new(256,70,viewport)
		@sprites["clock"].x = 380
		@sprites["clock"].y = (pbInBugContest?) ? (Graphics.height - 64) : 10
	end


	def update
		@time = pbGetTimeNow
		text = @time.strftime(CLOCK_TIME_FORMAT)
		textDay = @time.strftime("%A")
		@sprites["clock"].bitmap.clear
		pbSetSystemFont(@sprites["clock"].bitmap)
		pbDrawTextPositions(@sprites["clock"].bitmap,[[text,0,0,0,CLOCK_TEXTCOLOR,CLOCK_HIGHLIGHTCOLOR],[textDay,0,32,0,CLOCK_TEXTCOLOR,CLOCK_HIGHLIGHTCOLOR]])
	end
end


class SafariHud < Component
	def initialize(viewport, spritehash)
		super
		@sprites["safari"] = BitmapSprite.new(256,64,viewport)
		@sprites["safari"].x = 10
		@sprites["safari"].y = 10
		@textcolor = Color.new(244,244,244)
		@highlightColor = Color.new(30,30,30)
		@oldText
		@oldText2
	end

	def update
		text = _INTL("Balls: {1}",pbSafariState.ballcount)
		text2 = (Settings::SAFARI_STEPS>0) ? _INTL("Steps: {1}/{2}", pbSafariState.steps,Settings::SAFARI_STEPS) : ""

		if(@oldText != text || @oldText2 != text2)
			@oldText = text
			@oldText2 = text2
			@sprites["safari"].bitmap.clear
			pbSetSystemFont(@sprites["safari"].bitmap)
			pbDrawTextPositions(@sprites["safari"].bitmap,[[text,0,0,0,@textcolor,@highlightColor],[text2,0,32,0,@textcolor,@highlightColor]])
		end
	end
end

class BugContestHud < Component
	def initialize(viewport, spritehash)
		super
		@sprites["safari"] = BitmapSprite.new(256,96,viewport)
		@sprites["safari"].x = 10
		@sprites["safari"].y = 10
		@textcolor = Color.new(244,244,244)
		@highlightColor = Color.new(30,30,30)
		@oldText = ""
		@oldText2 = ""
		@oldText3 = ""
	end

	def update
		if(pbBugContestState.lastPokemon)
			text =  _INTL("Caught: {1}", PBSpecies.getName(pbBugContestState.lastPokemon.speciesName))
			text2 =  _INTL("Level: {1}", pbBugContestState.lastPokemon.level)
			text3 =  _INTL("Balls: {1}", pbBugContestState.ballcount)
		else
			text = "Caught: None"
			text2 = _INTL("Balls: {1}",pbBugContestState.ballcount)
			text3 = ""
		end

		if(@oldText != text || @oldText2 != text2 || @oldText3 != text3)
			@oldText = text
			@oldText2 = text2
			@oldText3 = text3
			@sprites["safari"].bitmap.clear
			pbSetSystemFont(@sprites["safari"].bitmap)
			pbDrawTextPositions(@sprites["safari"].bitmap,[[text,0,0,0,@textcolor,@highlightColor],[text2,0,32,0,@textcolor,@highlightColor],[text3,0,64,0,@textcolor,@highlightColor]])
		end
	end
end

class RadialMenu < Component
	def initialize(viewport, spritehash, menu)
		super(viewport, spritehash)
		@menu = menu

		@entries = []
		@originX = Graphics.width / 2 - ICON_WIDTH / 2
		@originY = Graphics.height / 2 - ICON_HEIGHT / 2
		@animationCounter = (ANIM_START_LENGTH > 0) ? ANIM_START_LENGTH : 1
		@currentSelection = 0 # The current selection, used as index for @entries
		@angleSize = 0
		@frameAngleShift = 0 # How many frames it takes to turn one time.

		# SAFARI  	= Bag		Trainer		Map	Quit	Options		Debug
		# BCONTEST 	= Pokemon 	Trainer		Map 	Quit 	Options		Debug
		addMenuEntry(MenuEntryPokemon.new) if $player.party_count > 0
		addMenuEntry(MenuEntryPokedex.new) if $player.has_pokedex && $player.pokedex.accessible_dexes.length > 0
		addMenuEntry(MenuEntryBag.new)  if !pbInBugContest?
		addMenuEntry(MenuEntryPokegear.new)  if $player.has_pokegear
    	addMenuEntry(MenuEntryMap.new) if $bag.has?(:TOWNMAP)
		addMenuEntry(MenuEntryExitBugContest.new) if pbInBugContest?
		addMenuEntry(MenuEntryExitSafari.new) if pbInSafari?
		addMenuEntry(MenuEntrySave.new)  if !pbInBugContest? && $game_system && !$game_system.save_disabled && !pbInSafari?
		addMenuEntry(MenuEntryDebug.new)if $DEBUG
		addMenuEntry(MenuEntryBoxes.new)
		addMenuEntry(MenuEntryQuests.new) if hasAnyQuests?
    	addMenuEntry(MenuEntryOptions.new)

		@sprites["entrytext"] = BitmapSprite.new(256,40,@viewport)
		@sprites["entrytext"].y = @originY +48
		@doingStartup = true
 		refreshMenuText
	end

	def addMenuEntry(entry)
		@entries << entry
		@sprites[entry.name] = IconSprite.new(0,0,@viewport)
		@sprites[entry.name].visible = false
		@sprites[entry.name].setBitmap(entry.icon)
		@sprites[entry.name].tone = INACTIVE_TONE
		@sprites[entry.name].opacity = INACTIVE_OPACITY
	end

	def update
		exit = false # should the menu-loop continue
		if(Input.trigger?(Input::B) || Input.trigger?(Input::A))
				@menu.shouldExit = true
				return
		end
		if(@animationCounter > 0)
			if(@doingStartup)
				@distance = 24 + (ANIM_START_LENGTH - @animationCounter) * ((MENU_DISTANCE - 24) / ANIM_START_LENGTH)
				positionMenuEntries
				@menu.pbHideMenu(false) if(ANIM_START_LENGTH== @animationCounter) # If it's the first frame
				transformIcon(@sprites[@entries[0].name], ACTIVE_SCALE, ACTIVE_TONE, ACTIVE_OPACITY)
				@animationCounter -= 1
				@doingStartup = false if (@animationCounter < 1)
			else
				updateAnimation
				refreshMenuText
			end
		else
			if Input.trigger?(BUTTON_COUNTERCLOCKWISE)
				startAnimation(1)
			elsif Input.trigger?(BUTTON_CLOCKWISE)
				startAnimation(-1)
			elsif Input.trigger?(Input::C)
				exit = @entries[@currentSelection].selected(@menu) # trigger selected entry.
			end
		end
		@menu.shouldExit = exit
	end


	# direction is either 1 (clockwise) or -1 (counterclockwise)
	def startAnimation(direction)
		@currentSelection =  (@currentSelection - direction) % @entries.length # keep selection within array bounds
		@currentAngle = BASE_ANGLE
		@frameAngleShift = direction * @angleSize / ANIM_TURN_LENGTH # in radians
		@frameScaleShift = ((ACTIVE_SCALE-1) / ANIM_TURN_LENGTH)
		@animationCounter = ANIM_TURN_LENGTH
		pbSEPlay(ANIM_TURN_SOUND)
	end

	def updateAnimation
		@animationCounter -= 1
		@entries.each do |entry|
			entry.angle += @frameAngleShift
			repositionSprite(@sprites[entry.name], entry.angle)
		end
		# Transition properties of selected/deselected entries
		newActive = @sprites[@entries[@currentSelection].name]
		if(@frameAngleShift > 0)
			oldActive = @sprites[@entries[(@currentSelection + 1) % @entries.length].name]
		else
			oldActive = @sprites[@entries[(@currentSelection - 1) % @entries.length].name]
		end
		scaleNew = 1 + @frameScaleShift * (ANIM_TURN_LENGTH - @animationCounter)
		scaleOld = 1 + @frameScaleShift * @animationCounter
		transformIcon(newActive, scaleNew, ACTIVE_TONE, ACTIVE_OPACITY)
		transformIcon(oldActive, scaleOld, INACTIVE_TONE, INACTIVE_OPACITY)
	end

	def refreshMenuText
		@sprites["entrytext"].bitmap.clear
		text = @entries[@currentSelection].name
		@sprites["entrytext"].x = @originX + 22 - text.length * 5.5 # rough guesstimate for centering
		@sprites["entrytext"].y = @originY
    pbSetSystemFont(@sprites["entrytext"].bitmap)
		pbDrawTextPositions(@sprites["entrytext"].bitmap,[[text,0,0,0,MENU_TEXTCOLOR,MENU_TEXTOUTLINE]])
	end

	def positionMenuEntries
		@currentAngle = BASE_ANGLE
		@angleSize = (2*Math::PI) / @entries.length
		@entries.each do |entry|
			entry.angle = @currentAngle
			repositionSprite(@sprites[entry.name], entry.angle)
			@currentAngle += @angleSize
		end
	end

	def repositionSprite(sprite, theta)
		sprite.y = (@distance * Math.sin(theta)) + @originY
		sprite.x = (@distance * Math.cos(theta)) + @originX
	end

	def transformIcon(sprite, scale, tone, opacity)
		width = sprite.bitmap.width
		height = sprite.bitmap.height
		sprite.zoom_x = scale
		sprite.zoom_y = scale
		sprite.x = sprite.x - (width*scale-width)/2
		sprite.y = sprite.y - (height*scale-height)/2
		sprite.tone = tone
		sprite.opacity = opacity
	end
end


class PokemonPauseMenu_Scene
	attr_accessor :shouldExit

	def initialize
		@background = Viewport.new(0,0,Graphics.width,Graphics.height)
		@viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
		@entries = []
		@sprites = {}
		@shouldExit = false
	end

	def pbStartScene
		@viewport.z = 99999
		@background.z = 99998
		@background.tone = BACKGROUND_TINT
		@clock = (ENABLE_CLOCK) ? Clock.new(@viewport, @sprites, CLOCK_TIME_FORMAT) : nil
		@safari = SafariHud.new(@viewport, @sprites) if (pbInSafari?)
		@safari = BugContestHud.new(@viewport, @sprites) if (pbInBugContest?)
		@radialMenu = RadialMenu.new(@viewport, @sprites, self)
	end

	def pbHideMenu(hide)
		@sprites.each do |_,sprite|
			sprite.visible = !hide
		end
	end

	def update
		@hasTerminated = false
		pbSEPlay("GUI menu open")
		 # face downward
		loop do
			if($game_player.direction != 2 && FORCE_PLAYER_LOOK_DOWN)
				@playerOldDirection = $game_player.direction
				$game_player.turn_down
				Graphics.update
				Input.update
				pbUpdateSceneMap
				next
			end
			Graphics.update
			Input.update
			@clock.update if ENABLE_CLOCK
			@safari.update if defined?(@safari)
			@radialMenu.update
			if(@hasTerminated)
				return # If pbEndScene was already called, don't call it again.
			end
			pbUpdateSceneMap
			if(shouldExit)
				pbEndScene
				break
			end
		end
		pbUpdateSpriteHash(@sprites)
	end

	def pbRefresh ; end
	def pbShowMenu ; end

	def closeNow
		@pbEndScene
		@hasTerminated = true
	end

	def pbEndScene
		@hasTerminated = true
		@background.dispose
		@radialMenu.dispose
		@safari.dispose if defined?(@safari)
		@clock.dispose if @clockEnabled
		pbDisposeSpriteHash(@sprites)
		@viewport.dispose
		$game_player.turnGeneric(@playerOldDirection) if defined?(@playerOldDirection)
	end
end


class PokemonPauseMenu
	def initialize(scene)
		@scene = scene

	end

	def pbShowMenu
		@scene.pbRefresh
		@scene.pbShowMenu
	end

	def pbStartPokemonMenu
		@scene.pbStartScene
		@scene.update
	end
end
