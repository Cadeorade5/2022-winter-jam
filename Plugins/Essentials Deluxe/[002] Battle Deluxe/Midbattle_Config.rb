#===============================================================================
# Essentials Deluxe module.
#===============================================================================
# Set up mid-battle triggers that may be called in a deluxe battle event.
# Add your custom midbattle hash here and you will be able to call upon it with
# the defined symbol, rather than writing out the entire thing in an event.
#-------------------------------------------------------------------------------


module EssentialsDeluxe
################################################################################
# Demo of all possible midbattle triggers.
################################################################################
  #-----------------------------------------------------------------------------
  # Displays speech indicating when each trigger is activated.
  #-----------------------------------------------------------------------------
  DEMO_SPEECH = {
    #---------------------------------------------------------------------------
    # Turn Phase Triggers
    #---------------------------------------------------------------------------
    "turnCommand"           => [:Self, "Trigger: 'turnCommand'\nCommand Phase start."],
    "turnAttack"            => [:Self, "Trigger: 'turnAttack'\nAttack Phase start."],
    "turnEnd"               => [:Self, "Trigger: 'turnEnd'\nEnd of Round Phase end."],
    #---------------------------------------------------------------------------
    # Move Usage Triggers
    #---------------------------------------------------------------------------
    "move"                  => [:Self, "Trigger: 'move'\nYour Pokémon successfully uses a move."],
    "move_foe"              => [:Self, "Trigger: 'move_foe'", "{1} successfully uses a move."],
    "move_ally"             => [:Self, "Trigger: 'move_ally'\nYour partner's Pokémon successfully uses a move."],
    "damageMove"            => [:Self, "Trigger: 'damageMove'\nYour Pokémon successfully uses a damage-dealing move."],
    "damageMove_foe"        => [:Self, "Trigger: 'damageMove_foe'", "{1} successfully uses a damage-dealing move."],
    "damageMove_ally"       => [:Self, "Trigger: 'damageMove_ally'\nYour partner's Pokémon successfully uses a damage-dealing move."],
    "physicalMove"          => [:Self, "Trigger: 'physicalMove'\nYour Pokémon successfully uses a physical move."],
    "physicalMove_foe"      => [:Self, "Trigger: 'physicalMove_foe'", "{1} successfully uses a physical move."],
    "physicalMove_ally"     => [:Self, "Trigger: 'physicalMove_ally'\nYour partner's Pokémon successfully uses a physical move."],
    "specialMove"           => [:Self, "Trigger: 'specialMove'\nYour Pokémon successfully uses a special move."],
    "specialMove_foe"       => [:Self, "Trigger: 'specialMove_foe'", "{1} successfully uses a special move."],
    "specialMove_ally"      => [:Self, "Trigger: 'specialMove_ally'\nYour partner's Pokémon successfully uses a special move."],
    "statusMove"            => [:Self, "Trigger: 'statusMove'\nYour Pokémon successfully uses a status move."],
    "statusMove_foe"        => [:Self, "Trigger: 'statusMove_foe'", "{1} successfully uses a status move."],
    "statusMove_ally"       => [:Self, "Trigger: 'statusMove_ally'\nYour partner's Pokémon successfully uses a status move."],
    #---------------------------------------------------------------------------
    # Attacker Triggers
    #---------------------------------------------------------------------------
    "superEffective"        => [:Self, "Trigger: 'superEffective'\nYour Pokémon's attack was super effective."],
    "superEffective_foe"    => [:Self, "Trigger: 'superEffective_foe'", "{1}'s attack was super effective."],
    "superEffective_ally"   => [:Self, "Trigger: 'superEffective_ally'\nYour partner's Pokémon's attack was super effective."],
    "notVeryEffective"      => [:Self, "Trigger: 'notVeryEffective'\nYour Pokémon's attack wasn't very effective."],
    "notVeryEffective_foe"  => [:Self, "Trigger: 'notVeryEffective_foe'", "{1}'s attack wasn't very effective."],
    "notVeryEffective_ally" => [:Self, "Trigger: 'notVeryEffective_ally'\nYour partner's Pokémon's attack wasn't very effective."],
    "immune"                => [:Self, "Trigger: 'immune'\nYour Pokémon's attack was negated or has no effect."],
    "immune_foe"            => [:Self, "Trigger: 'immune_foe'", "{1}'s attack was negated or has no effect."],
    "immune_ally"           => [:Self, "Trigger: 'immune_ally'\nYour partner's Pokémon's attack was negated or has no effect."],
    "miss"                  => [:Self, "Trigger: 'miss'\nYour Pokémon's attack missed."],
    "miss_foe"              => [:Self, "Trigger: 'miss_foe'", "{1}'s attack missed."],
    "miss_ally"             => [:Self, "Trigger: 'miss_ally'\nYour partner's Pokémon's attack missed."],
    "criticalHit"           => [:Self, "Trigger: 'criticalHit'\nYour Pokémon's attack dealt a critical hit."],
    "criticalHit_foe"       => [:Self, "Trigger: 'criticalHit_foe'", "{1}'s attack dealt a critical hit."],
    "criticalHit_ally"      => [:Self, "Trigger: 'criticalHit_ally'\nYour partner's Pokémon's attack dealt a critical hit."],
    #---------------------------------------------------------------------------
    # Defender Triggers
    #---------------------------------------------------------------------------
    "damageTaken"           => [:Self, "Trigger: 'damageTaken'\nYour Pokémon took damage from an attack."],
    "damageTaken_foe"       => [:Self, "Trigger: 'damageTaken_foe'", "{1} took damage from an attack."],
    "damageTaken_ally"      => [:Self, "Trigger: 'damageTaken_ally'\nYour partner's Pokémon took damage from an attack."],
    "statusInflicted"       => [:Self, "Trigger: 'statusInflicted'\nYour Pokémon was inflicted with a status condition."],
    "statusInflicted_foe"   => [:Self, "Trigger: 'statusInflicted_foe'", "{1} was inflicted with a status condition."],
    "statusInflicted_ally"  => [:Self, "Trigger: 'statusInflicted_ally'\nYour partner's Pokémon was inflicted with a status condition."],
    "halfHP"                => [:Self, "Trigger: 'halfHP'\nYour Pokémon's HP fell to 50% or lower after taking damage."],
    "halfHP_foe"            => [:Self, "Trigger: 'halfHP_foe'", "{1}'s HP fell to 50% or lower after taking damage."],
    "halfHP_ally"           => [:Self, "Trigger: 'halfHP_ally'\nYour partner's Pokémon's HP fell to 50% or lower after taking damage."],
    "halfHPLast"            => [:Self, "Trigger: 'halfHPLast'\nYour final Pokémon's HP fell to 50% or lower after taking damage."],
    "halfHPLast_foe"        => [:Self, "Trigger: 'halfHPLast_foe'", "{1}'s HP fell to 50% or lower after taking damage."],
    "halfHPLast_ally"       => [:Self, "Trigger: 'halfHPLast_ally'\nYour partner's final Pokémon's HP fell to 50% or lower after taking damage."],
    "lowHP"                 => [:Self, "Trigger: 'lowHP'\nYour Pokémon's HP fell to 25% or lower after taking damage."],
    "lowHP_foe"             => [:Self, "Trigger: 'lowHP_foe'", "{1}'s HP fell to 25% or lower after taking damage."],
    "lowHP_ally"            => [:Self, "Trigger: 'lowHP_ally'\nYour partner's Pokémon's HP fell to 25% or lower after taking damage."],
    "lowHPLast"             => [:Self, "Trigger: 'lowHPLast'\nYour final Pokémon's HP fell to 25% or lower after taking damage."],
    "lowHPLast_foe"         => [:Self, "Trigger: 'lowHPLast_foe'", "{1}'s HP fell to 25% or lower after taking damage."],
    "lowHPLast_ally"        => [:Self, "Trigger: 'lowHPLast_ally'\nYour partner's final Pokémon's HP fell to 25% or lower after taking damage."],
    "fainted"               => [:Self, "Trigger: 'fainted'\nYour Pokémon fainted."],
    "fainted_foe"           => [:Self, "Trigger: 'fainted_foe'", "{1} fainted."],
    "fainted_ally"          => [:Self, "Trigger: 'fainted_ally'\nYour partner's Pokémon fainted."],
    #---------------------------------------------------------------------------
    # Switching Triggers
    #---------------------------------------------------------------------------
    "recall"                => [:Self, "Trigger: 'recall'\nYou withdrew an active Pokémon."],
    "recall_foe"            => [:Self, "Trigger: 'recall_foe'\nI withdrew an active Pokémon."],
    "recall_ally"           => [:Self, "Trigger: 'recall_ally'\nYour partner withdrew an active Pokémon."],
    "beforeNext"            => [:Self, "Trigger: 'beforeNext'\nYou intend to send out a Pokémon."],
    "beforeNext_foe"        => [:Self, "Trigger: 'beforeNext_foe'\nI intend to send out a Pokémon."],
    "beforeNext_ally"       => [:Self, "Trigger: 'beforeNext_ally'\nYour partner intends to send out a Pokémon."],
    "afterNext"             => [:Self, "Trigger: 'afterNext'\nYou successfully sent out a Pokémon."],
    "afterNext_foe"         => [:Self, "Trigger: 'afterNext_foe'\nI successfully sent out a Pokémon."],
    "afterNext_ally"        => [:Self, "Trigger: 'afterNext_ally'\nYour partner successfully sent out a Pokémon."],
    "beforeLast"            => [:Self, "Trigger: 'beforeLast'\nYou intend to send out your final Pokémon."],
    "beforeLast_foe"        => [:Self, "Trigger: 'beforeLast_foe'\nI intend to send out my final Pokémon."],
    "beforeLast_ally"       => [:Self, "Trigger: 'beforeLast_ally'\nYour partner intends to send out their final Pokémon."],
    "afterLast"             => [:Self, "Trigger: 'afterLast'\nYou successfully sent out your final Pokémon."],
    "afterLast_foe"         => [:Self, "Trigger: 'afterLast_foe'\nI successfully sent out my final Pokémon."],
    "afterLast_ally"        => [:Self, "Trigger: 'afterLast_ally'\nYour partner successfully sent out their final Pokémon."],
    #---------------------------------------------------------------------------
    # Special Action Triggers
    #---------------------------------------------------------------------------
    "item"                  => [:Self, "Trigger: 'item'\nYou used an item from your inventory."],
    "item_foe"              => [:Self, "Trigger: 'item_foe'\nI used an item from my inventory."],
    "item_ally"             => [:Self, "Trigger: 'item_ally'\nYour partner used an item from their inventory."],
    "mega"                  => [:Self, "Trigger: 'mega'\nYou initiate Mega Evolution."],
    "mega_foe"              => [:Self, "Trigger: 'mega_foe'\nI initiate Mega Evolution."],
    "mega_ally"             => [:Self, "Trigger: 'mega_ally'\nYour partner initiates Mega Evolution."],
    #---------------------------------------------------------------------------
    # Plugin Triggers
    #---------------------------------------------------------------------------
    "zmove"                 => [:Self, "Trigger: 'zmove'\nYou initiate a Z-Move."],
    "zmove_foe"             => [:Self, "Trigger: 'zmove_foe'\nI initiate a Z-Move."],
    "zmove_ally"            => [:Self, "Trigger: 'zmove_ally'\nYour partner initiates a Z-Move."],
    "ultra"                 => [:Self, "Trigger: 'ultra'\nYou initiate Ultra Burst."],
    "ultra_foe"             => [:Self, "Trigger: 'ultra_foe'\nI initiate Ultra Burst."],
    "ultra_ally"            => [:Self, "Trigger: 'ultra_ally'\nYour partner initiates Ultra Burst."],
    "dynamax"               => [:Self, "Trigger: 'dynamax'\nYou initiate Dynamax."],
    "dynamax_foe"           => [:Self, "Trigger: 'dynamax_foe'\nI initiate Dynamax."],
    "dynamax_ally"          => [:Self, "Trigger: 'dynamax_ally'\nYour partner initiates Dynamax."],
    "battleStyle"           => [:Self, "Trigger: 'battleStyle'\nYou initiate a battle style."],
    "battleStyle_foe"       => [:Self, "Trigger: 'battleStyle_foe'\nOpponent initiates a battle style."],
    "battleStyle_ally"      => [:Self, "Trigger: 'battleStyle_ally'\nYour partner initiates a battle style."],
    "strongStyle"           => [:Self, "Trigger: 'strongStyle'\nYou initiate Strong Style."],
    "strongStyle_foe"       => [:Self, "Trigger: 'strongStyle_foe'\nOpponent initiates Strong Style."],
    "strongStyle_ally"      => [:Self, "Trigger: 'strongStyle_ally'\nYour partner initiates Strong Style."],
    "agileStyle"            => [:Self, "Trigger: 'agileStyle'\nYou initiate Agile Style."],
    "agileStyle_foe"        => [:Self, "Trigger: 'agileStyle_foe'\nOpponent initiates Agile Style."],
    "agileStyle_ally"       => [:Self, "Trigger: 'agileStyle_ally'\nYour partner initiates Agile Style."],
    "styleEnd"              => [:Self, "Trigger: 'styleEnd'\nYour style cooldown expired."],
    "styleEnd_foe"          => [:Self, "Trigger: 'styleEnd_foe'\nOpponent style cooldown expired."],
    "styleEnd_ally"         => [:Self, "Trigger: 'styleEnd_ally'\nYour partner's style cooldown expired."],
    "zodiac"                => [:Self, "Trigger: 'zodiac'\nYou initiate a Zodiac Power."],
    "zodiac_foe"            => [:Self, "Trigger: 'zodiac_foe'\nI initiate a Zodiac Power."],
    "zodiac_ally"           => [:Self, "Trigger: 'zodiac_ally'\nYour partner initiates a Zodiac Power."],
    "focus"                 => [:Self, "Trigger: 'focus'\nYour Pokémon harnesses its focus."],
    "focus_foe"             => [:Self, "Trigger: 'focus_foe'", "{1} harnesses its focus."],
    "focus_ally"            => [:Self, "Trigger: 'focus_ally'\nYour partner's Pokémon harnesses its focus."],
    "focusBoss"             => [:Self, "Trigger: 'focus_boss'", "{1} harnesses its focus with the Enraged style."],
    "focusEnd"              => [:Self, "Trigger: 'focusEnd'", "Your Pokemon's Focus was used."],
    "focusEnd_foe"          => [:Self, "Trigger: 'focusEnd_foe'", "Opponent Pokemon's Focus was used."],
    "focusEnd_ally"         => [:Self, "Trigger: 'focusEnd_ally'", "Your partner Pokemon's Focus was used."],
    #---------------------------------------------------------------------------
    # Player-only Triggers
    #---------------------------------------------------------------------------
    "beforeCapture"         => [:Self, "Trigger: 'beforeCapture'\nYou intend to throw a selected Poké Ball."],
    "afterCapture"          => [:Self, "Trigger: 'afterCapture'\nYou successfully captured the targeted Pokémon."],
    "failedCapture"         => [:Self, "Trigger: 'failedCapture'\nYou failed to capture the targeted Pokémon."],
    "loss"                  => [:Self, "Trigger: 'loss'\nYou lost the battle."]
  }
  
  
################################################################################
# Example demo of a generic capture tutorial battle.
################################################################################  
  #-----------------------------------------------------------------------------
  # Demo capture tutorial vs. wild Pokemon.
  #-----------------------------------------------------------------------------
  DEMO_CAPTURE_TUTORIAL = {
    #---------------------------------------------------------------------------
    # General speech events.
    #---------------------------------------------------------------------------
    "turnCommand"       => "Hey! A wild Pokémon!\nPay attention, now. I'll show you how to capture one of your own!",
    "damageMove"        => ["Weakening a Pokémon through battle makes them much easier to catch!",
                            "Be careful though - you don't want to knock them out completely!\nYou'll lose your chance if you do!",
                            "Let's try dealing some damage.\nGet 'em, {1}!"],
    "inflictStatus_foe" => ["It's always a good idea to inflict status conditions like Sleep or Paralysis!",
                            "This will really help improve your odds at capturing the Pokémon!"],
    #---------------------------------------------------------------------------
    # Continuous - Applies Endure effect to wild Pokemon whenever targeted by
    #              a damage-dealing move. Ensures it is not KO'd early.
    #---------------------------------------------------------------------------
    "damageMove_repeat" => {
      :battler => :Opposing,
      :effects => [[PBEffects::Endure, true]]
    },
    #---------------------------------------------------------------------------
    # Continuous - Checks if the wild Pokemon's HP is low. If so, initiates the
    #              capture sequence.
    #---------------------------------------------------------------------------
    "turnEnd_repeat" => {
      :delay   => ["halfHP_foe", "lowHP_foe"],
      :useitem => :POKEBALL
    },
    #---------------------------------------------------------------------------
    # Capture speech events.
    #---------------------------------------------------------------------------
    "beforeCapture" => "The Pokémon is weak!\nNow's the time to throw a Poké Ball!",
    "afterCapture"  => "Alright, that's how it's done!",
    #---------------------------------------------------------------------------
    # Capture failed - The wild Pokemon flees if it wasn't captured.
    #---------------------------------------------------------------------------
    "failedCapture" => {
      :speech    => "Drat! I thought I had it...",
      :playSE    => "Battle flee",
      :battler   => :Opposing,
      :text      => "{1} fled!",
      :endbattle => 3
    }
  }
  

################################################################################
# Demo scenario vs. AI Sada, as encountered in Pokemon Scarlet.
################################################################################
  #-----------------------------------------------------------------------------
  # Phase 1 - Speech events.
  #-----------------------------------------------------------------------------
  DEMO_VS_SADA_PHASE_1 = {
    "turnCommand"        => "I don't know who you think you are, but I'm not about to let anyone get in the way of my goals.",
    "damageTaken"        => "This is the power the ancient past holds.\nSplendid, isn't it?",
    "superEffective"     => "Now, this is interesting... Child, do you actually understand ancient Pokémon's weaknesses?",
    "superEffective_foe" => "Do you imagine you can best the wealth of data at my disposal with your human brain?",
    "criticalHit"        => "What?! Some sort of error has occurred here...\nRecalculating for critical damage...",
    "criticalHit_foe"    => "Just as calculated: a critical hit to your Pokémon.\nIt's time you simply gave up, child.",
    "beforeLast_foe"     => "Everything is proceeding within my expectations. I'm afraid the probability of you winning is zero."
  }
  
  #-----------------------------------------------------------------------------
  # Phase 2 - Scripted Koraidon battle.
  #-----------------------------------------------------------------------------
  DEMO_VS_SADA_PHASE_2 = {
    #---------------------------------------------------------------------------
    # Continuous - Applies Endure effect to player's Pokemon when the opponent
    #              uses a damaging move. Ensures the player's Pokemon is not KO'd
    #              even if they fail to select Endure when necessary.
    #---------------------------------------------------------------------------
    "damageMove_foe_repeat" => {
      :battler => :Opposing,
      :effects => [[PBEffects::Endure, true]]
    },
    #---------------------------------------------------------------------------
    # Continuous - Forces opponent to Taunt every turn after Turn 6. Ensures
    #              the player must eventually defeat the opponent.
    #---------------------------------------------------------------------------
    "turnAttack_repeat" => {
      :delay   => "turnAttack_6",
      :battler => :Opposing,
      :usemove => :TAUNT
    },
    #---------------------------------------------------------------------------
    # Turn 1 - Battle intro; ensures opponent has correct moves. Opponent is
    #          forced to Taunt this turn. Speech event.
    #---------------------------------------------------------------------------
    "turnCommand" => {
      :battler     => :Opposing,
      :blankspeech => [:GROWL, "Grah! Grrrrrraaagh!"],
      :moves       => [:TAUNT, :BULKUP, :FLAMETHROWER, :GIGAIMPACT]
    }, 
    "turnAttack_1" => {
      :battler => :Opposing,
      :usemove => :TAUNT
    },
    "turnEnd_1" => {
      :blankspeech => "NEMONA: It changed into its battle form! Let's go, Koraidon - you got this!"
    },
    #---------------------------------------------------------------------------
    # Turn 2 - Opponent is forced to Flamethrower. Player's side silently given
    #          Safeguard this turn to ensure burn cannot occur. Opponent speech.
    #---------------------------------------------------------------------------
    "turnAttack_2" => {
      :team      => [[PBEffects::Safeguard, 2]],
      :battler   => :Opposing,
      :speech    => "You will fall here, within this garden paradise - and achieve nothing in the end.",
      :usemove   => :FLAMETHROWER
    },
    "turnEnd_2" => {
      :team => [[PBEffects::Safeguard, 0]]
    },
    #---------------------------------------------------------------------------
    # Turn 3 - Opponent is forced to Bulk Up. Ensures Taunt effect is ended on
    #          Player's Pokemon to setup Endure next turn. Speech events.
    #---------------------------------------------------------------------------
    "turnAttack_3" => {
      :battler => :Opposing,
      :speech  => "You will not be allowed to destroy my paradise. Obstacles to my goals WILL be eliminated.",
      :usemove => :BULKUP
    },
    "turnEnd_3" => {
      :effects     => [[PBEffects::Taunt, 0, "{1} shook off the taunt!"]],
      :blankspeech => "PENNY: Th-this looks like it could be bad! Uh...hang in there, {2}!"
    },
    #---------------------------------------------------------------------------
    # Turn 4 - Opponent is forced to Giga Impact. Opponent silently given No Guard
    #          ability this turn to ensure move lands. Player's Pokemon's Attack
    #          increased by 2 stages. Speech events.
    #---------------------------------------------------------------------------
    "turnAttack_4" => {
      :battler => :Opposing,
      :speech  => "The data says I am the superior. Fall, and become a foundation upon which my dream may be built.",
      :ability => :NOGUARD,
      :usemove => :GIGAIMPACT
    },
    "turnEnd_4" => {
      :blankspeech => "ARVEN: You took that hit like a champ! You can do this! I know you can!",
      :stats       => [:ATTACK, 2],
      :battler     => :Opposing,
      :ability     => :Reset,
    },
    #---------------------------------------------------------------------------
    # Turn 5 - Toggles the availability of Terastallization, assuming its
    #          functionality has been turned off for this battle. Raises Player's
    #          Pokemon's stats by 1 stage if the opponent's HP is low. Speech event.
    #---------------------------------------------------------------------------
    "turnEnd_5" => {
      :blankspeech => ["NEMONA: Oh man, can we really not pull off a win here? This doesn't look good...",
                       "PENNY: H-hey {2}! Your Tera Orb is glowing!",
                       "ARVEN: {2}! Koraidon! Terastallize and finish this off!"],
      :lockspecial => :Terastallize,
      :delay       => ["lowHP_foe", "halfHP_foe"],
      :stats       => [:ATTACK, 1, :DEFENSE, 1, :SPECIAL_ATTACK, 1, :SPECIAL_DEFENSE, 1, :SPEED, 1]
    },
    #---------------------------------------------------------------------------
    # Turn 6 - Raises Player's Pokemon's stats by 1 stage in case it wasn't
    #          triggered on the previous turn. Speech event.
    #---------------------------------------------------------------------------
    "turnEnd_6" => {
      :blankspeech => "PENNY: Show'em you won't be pushed around! Time to Terastallize and get in some supereffective hits!",
      :stats       => [:ATTACK, 1, :DEFENSE, 1, :SPECIAL_ATTACK, 1, :SPECIAL_DEFENSE, 1, :SPEED, 1]
    }
  }
  

################################################################################
# Custom demo scenario vs. wild Pokemon.
################################################################################  
  #-----------------------------------------------------------------------------
  # Demo scenario vs. wild Rotom that shifts forms.
  #-----------------------------------------------------------------------------
  DEMO_WILD_ROTOM = {
    #---------------------------------------------------------------------------
    # Turn 1 - Battle intro.
    #---------------------------------------------------------------------------
    "turnCommand" => {
      :text      => [:Opposing, "{1} emited a powerful magnetic pulse!"],
      :anim      => [:CHARGE, :Opposing],
      :playsound => "Anim/Paralyze3",
      :text_1    => "Your Poké Balls short-circuited!\nThey cannot be used this battle!"
    },
    #---------------------------------------------------------------------------
    # Continuous - After taking a supereffective hit, the wild Rotom changes to
    #              a random form and changes its item/ability. HP and status
    #              are also healed.
    #---------------------------------------------------------------------------
    "turnEnd_repeat" => {
      :delay   => "superEffective",
      :battler => :Opposing,
      :anim    => [:NIGHTMARE, :Self],
      :form    => [:Random, "{1} possessed a new appliance!"],
      :hp      => 4,
      :status  => :NONE,
      :ability => [:MOTORDRIVE, true],
      :item    => [:CELLBATTERY, "{1} equipped a Cell Battery it found in the appliance!"]
    },
    #---------------------------------------------------------------------------
    # Continuous - After the wild Rotom's HP gets low, applies the Charge,
    #              Magnet Rise, and Electric Terrain effects whenever the wild
    #              Rotom takes damage from an attack.
    #---------------------------------------------------------------------------
    "damageTaken_foe_repeat" => {
      :delay   => ["halfHP_foe", "lowHP_foe"],
      :effects => [
        [PBEffects::Charge,     5, "{1} began charging power!"],
        [PBEffects::MagnetRise, 5, "{1} levitated with electromagnetism!"],
      ],
      :terrain => :Electric
    },
    #---------------------------------------------------------------------------
    # Player's Pokemon becomes paralyzed after dealing supereffective damage. 
    #---------------------------------------------------------------------------
    "superEffective" => {
      :text    => [:Opposing, "{1} emited an electrical pulse out of desperation!"],
      :status  => [:PARALYSIS, true]
    }
  }
  
  
################################################################################
# Custom demo scenario vs. trainer.
################################################################################  
  #-----------------------------------------------------------------------------
  # Demo scenario vs. Rocket Grunt in a collapsing cave.
  #-----------------------------------------------------------------------------
  DEMO_COLLAPSING_CAVE = {
    #---------------------------------------------------------------------------
    # Turn 1 - Battle intro.
    #---------------------------------------------------------------------------
    "turnCommand" => {
      :playSE  => "Mining collapse",
      :text    => "The cave ceiling begins to crumble down all around you!",
      :speech  => [:Opposing, "I am not letting you escape!", 
                   "I don't care if this whole cave collapses down on the both of us...haha!"],
      :text_1  => "Defeat your opponent before time runs out!"
    },
    #---------------------------------------------------------------------------
    # Turn 2 - Player's Pokemon takes damage and becomes confused.
    #---------------------------------------------------------------------------
    "turnEnd_2" => {
      :text    => "{1} was struck on the head by a falling rock!",
      :anim    => [:ROCKSMASH, :Self],
      :hp      => -4,
      :status  => :CONFUSION
    },
    #---------------------------------------------------------------------------
    # Turn 3 - Text event.
    #---------------------------------------------------------------------------
    "turnEnd_3" => {
      :text => ["You're running out of time!", 
                "You need to escape immediately!"]
    },
    #---------------------------------------------------------------------------
    # Turn 4 - Battle prematurely ends in a loss.
    #---------------------------------------------------------------------------
    "turnEnd_4" => {
      :text      => ["You failed to defeat your opponent in time!", 
                     "You were forced to flee the battle!"],
      :playsound => "Battle flee",
      :endbattle => 2
    },
    #---------------------------------------------------------------------------
    # Continuous - Text event at the end of each turn.
    #---------------------------------------------------------------------------
    "turnEnd_repeat" => {
      :playsound => "Mining collapse",
      :text      => "The cave continues to collapse all around you!"
    },
    #---------------------------------------------------------------------------
    # Opponent's final Pokemon is healed and increases its defenses when HP is low.
    #---------------------------------------------------------------------------
    "lowHPLast_foe" => {
      :speech  => "My {1} will never give up!",
      :anim    => [:BULKUP, :Self],
      :playcry => true,
      :hp      => [2, "{1} is standing its ground!"],
      :stats   => [:DEFENSE, 2, :SPECIAL_DEFENSE, 2]
    },
    #---------------------------------------------------------------------------
    # Speech event upon losing the battle.
    #---------------------------------------------------------------------------
    "loss" => "Haha...you'll never make it out alive!"
  }
  
  
################################################################################
# Demo speech displays for use with certain battle mechanics added by plugins.
################################################################################
  #-----------------------------------------------------------------------------
  # Demo trainer speech when triggering ZUD Mechanics.
  #-----------------------------------------------------------------------------
  DEMO_ZUD_MECHANICS = {
    "zmove_foe"   => ["Alright, {1}!", "Time to unleash our Z-Power!"],
    "ultra_foe"   => "Hah! Prepare to witness my {1}'s ultimate form!",
    "dynamax_foe" => ["No holding back!", "It's time to Dynamax!"]
  }
  
  #-----------------------------------------------------------------------------
  # Demo trainer speech when triggering the Focus Meter.
  #-----------------------------------------------------------------------------
  DEMO_FOCUS_METER = {
    "focus_foe" => "Focus, {1}!\nWe got this!", 
    "focus_foe_repeat" => {
      :delay  => "focusEnd_foe",
      :speech => "Keep your eye on the prize, {1}!"
    },
    "focusBoss" => "It's time to let loose, {1}!",
    "focusBoss_repeat" => {
      :delay  => "focusEnd_foe",
      :speech => "No mercy! Show them your rage, {1}!"
    }
  }

  #-----------------------------------------------------------------------------
  # Demo trainer speech when triggering PLA Battle Styles.
  #-----------------------------------------------------------------------------
  DEMO_BATTLE_STYLES = {
    "strongStyle_foe" => "Let's strike 'em down with all your strength, {1}!",
    "strongStyle_foe_repeat" => {
      :delay  => "styleEnd_foe",
      :speech => ["Let's keep up the pressure!", 
                  "Hit 'em with your Strong Style, {1}!"]
    },
    "agileStyle_foe" => "Let's strike 'em down before they know what hit 'em, {1}!",
    "agileStyle_foe_repeat" => {
      :delay  => "styleEnd_foe",
      :speech => ["Let's keep them on their toes!", 
                  "Hit 'em with your Agile Style, {1}!"]
    }
  }
end