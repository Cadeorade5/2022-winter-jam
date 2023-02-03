#===============================================================================
# Makes additions to various battle code to allow mid-battle settings to trigger.
#===============================================================================


class Battle::Scene
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when a Pokemon faints.
  #-----------------------------------------------------------------------------
  alias dx_pbFaintBattler pbFaintBattler
  def pbFaintBattler(battler)
    dx_pbFaintBattler(battler)
    if !@battle.pbAllFainted?(battler.index)
      trigger = (battler.pbOwnedByPlayer?) ? "fainted" : (battler.opposes?) ? "fainted_foe" : "fainted_ally"
      dx_midbattle(battler.index, nil, trigger)
    end
  end
end


class Battle
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when items are used.
  #-----------------------------------------------------------------------------
  alias dx_pbUseItemOnPokemon pbUseItemOnPokemon
  def pbUseItemOnPokemon(*args)
    trigger = (args[2].pbOwnedByPlayer?) ? "item" : (args[2].opposes?) ? "item_foe" : "item_ally"
    @scene.dx_midbattle(args[2].index, nil, trigger)
    dx_pbUseItemOnPokemon(*args)
  end

  alias dx_pbUseItemOnBattler pbUseItemOnBattler
  def pbUseItemOnBattler(*args)
    trigger = (args[2].pbOwnedByPlayer?) ? "item" : (args[2].opposes?) ? "item_foe" : "item_ally"
    @scene.dx_midbattle(args[2].index, nil, trigger)
    dx_pbUseItemOnBattler(*args)
  end
  
  alias dx_pbUseItemInBattle pbUseItemInBattle
  def pbUseItemInBattle(item, idxBattler, userBattler)
    trigger = (userBattler.pbOwnedByPlayer?) ? "item" : (userBattler.opposes?) ? "item_foe" : "item_ally"
    @scene.dx_midbattle(userBattler.index, idxBattler, trigger)
    dx_pbUseItemInBattle(item, idxBattler, userBattler)
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when Pokemon are recalled and sent out.
  #-----------------------------------------------------------------------------
  alias dx_pbMessageOnRecall pbMessageOnRecall
  def pbMessageOnRecall(battler)
    trigger = (battler.pbOwnedByPlayer?) ? "recall" : (battler.opposes?) ? "recall_foe" : "recall_ally"
    @scene.dx_midbattle(battler.index, nil, trigger) if !battler.fainted?
    dx_pbMessageOnRecall(battler)
  end
  
  alias dx_pbMessagesOnReplace pbMessagesOnReplace
  def pbMessagesOnReplace(idxBattler, idxParty)
    if pbAbleNonActiveCount(idxBattler) == 1
      trigger = (pbOwnedByPlayer?(idxBattler)) ? "beforeLast" : (opposes?(idxBattler)) ? "beforeLast_foe" : "beforeLast_ally"
    else
      trigger = (pbOwnedByPlayer?(idxBattler)) ? "beforeNext" : (opposes?(idxBattler)) ? "beforeNext_foe" : "beforeNext_ally"
    end
    @scene.dx_midbattle(idxBattler, nil, trigger)
    dx_pbMessagesOnReplace(idxBattler, idxParty)
  end
  
  alias dx_pbReplace pbReplace
  def pbReplace(*args)
    dx_pbReplace(*args)
    if pbAbleNonActiveCount(args[0]) == 0
      trigger = (pbOwnedByPlayer?(args[0])) ? "afterLast" : (opposes?(args[0])) ? "afterLast_foe" : "afterLast_ally"
    else
      trigger = (pbOwnedByPlayer?(args[0])) ? "afterNext" : (opposes?(args[0])) ? "afterNext_foe" : "afterNext_ally"
    end
    @scene.dx_midbattle(args[0], nil, trigger)
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for Mega Evolution.
  #-----------------------------------------------------------------------------
  alias dx_pbMegaEvolve pbMegaEvolve
  def pbMegaEvolve(idxBattler)
    battler = @battlers[idxBattler]
    return if !battler || !battler.pokemon
    return if !battler.hasMega? || battler.mega?
    trigger = (pbOwnedByPlayer?(idxBattler)) ? "mega" : (opposes?(idxBattler)) ? "mega_foe" : "mega_ally"
    @scene.dx_midbattle(idxBattler, nil, trigger)
    dx_pbMegaEvolve(idxBattler)
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for the end of round.
  #-----------------------------------------------------------------------------
  alias dx_pbEndOfRoundPhase pbEndOfRoundPhase
  def pbEndOfRoundPhase
    ret = dx_pbEndOfRoundPhase
    @scene.dx_midbattle(nil, nil, "turnEnd", "turnEnd_" + (1 + @turnCount).to_s)
    return ret
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers upon losing a battle.
  #-----------------------------------------------------------------------------
  alias dx_pbLoseMoney pbLoseMoney
  def pbLoseMoney
    @scene.dx_midbattle(nil, nil, "loss")
    dx_pbLoseMoney
  end
end


module Battle::CatchAndStoreMixin
  #-----------------------------------------------------------------------------
  # Mid-battle triggers during the capture process.
  #-----------------------------------------------------------------------------
  alias dx_pbThrowPokeBall pbThrowPokeBall
  def pbThrowPokeBall(*args)
    idxBattler = args[0]
    if opposes?(idxBattler)
      battler = @battlers[idxBattler]
    else
      battler = @battlers[idxBattler].pbDirectOpposing(true)
    end
    personalID = battler.pokemon.personalID
    @scene.dx_midbattle(idxBattler, battler.index, "beforeCapture")
    dx_pbThrowPokeBall(*args)
    captured = false
    @caughtPokemon.each { |p| captured = true if p.personalID == personalID }
    if captured
      @scene.dx_midbattle(nil, nil, "afterCapture") 
    else
      @scene.dx_midbattle(nil, nil, "failedCapture") 
    end
  end
end


class Battle::Battler
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when a move is used.
  #-----------------------------------------------------------------------------
  alias dx_pbTryUseMove pbTryUseMove
  def pbTryUseMove(*args)
    ret = dx_pbTryUseMove(*args)
    if ret
      triggers = []
      type = args[1].type.to_s
      trigs = ["move", "move" + type, "move" + args[1].id.to_s]
      if args[1].damagingMove?
        trigs.push("damageMove", "damageMove" + type)
        trigs.push("physicalMove", "physicalMove" + type) if args[1].physicalMove?
        trigs.push("specialMove", "specialMove" + type) if args[1].specialMove?
      else
        trigs.push("statusMove", "statusMove" + type)
      end
      trigs.each { |t| triggers.push((pbOwnedByPlayer?) ? t : (opposes?) ? t + "_foe" : t + "_ally") }
      @battle.scene.dx_midbattle(@index, args[0][3], *triggers) if !triggers.empty?
    end
    return ret
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when a used move fails.
  #-----------------------------------------------------------------------------
  alias dx_pbSuccessCheckAgainstTarget pbSuccessCheckAgainstTarget
  def pbSuccessCheckAgainstTarget(move, user, target, targets)
    ret = dx_pbSuccessCheckAgainstTarget(move, user, target, targets)
    if !ret
      trigger = (user.pbOwnedByPlayer?) ? "immune" : (user.opposes?) ? "immune_foe" : "immune_ally"
      @battle.scene.dx_midbattle(user.index, target.index, trigger)
    end
    return ret
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when a used move misses.
  #-----------------------------------------------------------------------------
  alias dx_pbMissMessage pbMissMessage
  def pbMissMessage(move, user, target)
    dx_pbMissMessage(move, user, target)
    trigger = (user.pbOwnedByPlayer?) ? "miss" : (user.opposes?) ? "miss_foe" : "miss_ally"
    @battle.scene.dx_midbattle(user.index, target.index, trigger)
  end
  
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when a status condition is inflicted.
  #-----------------------------------------------------------------------------
  alias dx_pbInflictStatus pbInflictStatus 
  def pbInflictStatus(*args)
    oldStatus = self.status
    dx_pbInflictStatus(*args)
    if ![:NONE, oldStatus].include?(self.status)
      trigger = (pbOwnedByPlayer?) ? "inflictStatus" : (opposes?) ? "inflictStatus_foe" : "inflictStatus_ally"
      @battle.scene.dx_midbattle(@index, nil, trigger)
    end
  end
end


class Battle::Move
  #-----------------------------------------------------------------------------
  # Mid-battle triggers for type effectiveness of a used move.
  #-----------------------------------------------------------------------------
  def pbEffectivenessMessage(user, target, numTargets = 1)
    return if target.damageState.disguise || target.damageState.iceFace
    trigger = nil
    if Effectiveness.super_effective?(target.damageState.typeMod)
      if numTargets > 1
        @battle.pbDisplay(_INTL("It's super effective on {1}!", target.pbThis(true)))
      else
        @battle.pbDisplay(_INTL("It's super effective!"))
      end
      trigger = (user.pbOwnedByPlayer?) ? "superEffective" : (user.opposes?) ? "superEffective_foe" : "superEffective_ally"
    elsif Effectiveness.not_very_effective?(target.damageState.typeMod)
      if numTargets > 1
        @battle.pbDisplay(_INTL("It's not very effective on {1}...", target.pbThis(true)))
      else
        @battle.pbDisplay(_INTL("It's not very effective..."))
      end
      trigger = (user.pbOwnedByPlayer?) ? "notVeryEffective" : (user.opposes?) ? "notVeryEffective_foe" : "notVeryEffective_ally"
    end
    return trigger
  end

  #-----------------------------------------------------------------------------
  # Mid-battle triggers for when a used move deals damage.
  #-----------------------------------------------------------------------------
  def pbHitEffectivenessMessages(user, target, numTargets = 1)
    return if target.damageState.disguise || target.damageState.iceFace
    if target.damageState.substitute
      @battle.pbDisplay(_INTL("The substitute took damage for {1}!", target.pbThis(true)))
    end
    user_triggers = []
    target_triggers = []
    if target.damageState.critical
      if $game_temp.party_critical_hits_dealt &&
         $game_temp.party_critical_hits_dealt[user.pokemonIndex] &&
         user.pbOwnedByPlayer?
        $game_temp.party_critical_hits_dealt[user.pokemonIndex] += 1
      end
      if target.damageState.affection_critical
        if numTargets > 1
          @battle.pbDisplay(_INTL("{1} landed a critical hit on {2}, wishing to be praised!",
                                  user.pbThis, target.pbThis(true)))
        else
          @battle.pbDisplay(_INTL("{1} landed a critical hit, wishing to be praised!", user.pbThis))
        end
      elsif numTargets > 1
        @battle.pbDisplay(_INTL("A critical hit on {1}!", target.pbThis(true)))
      else
        @battle.pbDisplay(_INTL("A critical hit!"))
      end
      user_triggers.push((user.pbOwnedByPlayer?) ? "criticalHit" : (user.opposes?) ? "criticalHit_foe" : "criticalHit_ally") if user.opposes?(target.index)
    end
    if !multiHitMove? && user.effects[PBEffects::ParentalBond] == 0
      effectiveness_trigger = pbEffectivenessMessage(user, target, numTargets)
      user_triggers.push(effectiveness_trigger) if effectiveness_trigger && user.opposes?(target.index)
    end
    if target.damageState.substitute && target.effects[PBEffects::Substitute] == 0
      target.effects[PBEffects::Substitute] = 0
      @battle.pbDisplay(_INTL("{1}'s substitute faded!", target.pbThis))
    end
    if !target.damageState.substitute
      @battle.scene.dx_midbattle(user.index, target.index, *user_triggers) if user_triggers.length > 0
      target_triggers.push((target.pbOwnedByPlayer?) ? "damageTaken" : (target.opposes?) ? "damageTaken_foe" : "damageTaken_ally") if user.opposes?(target.index)
      if !target.fainted? && user.opposes?(target.index)
        if target.hp <= target.totalhp / 4
          if @battle.pbParty(target.index).length > @battle.pbSideSize(target.index)
            if @battle.pbAbleNonActiveCount(target.index) == 0
              target_triggers.push((target.pbOwnedByPlayer?) ? "lowHPFinal" : (target.opposes?) ? "lowHPFinal_foe" : "lowHPFinal_ally")
            else
              target_triggers.push((target.pbOwnedByPlayer?) ? "lowHP" : (target.opposes?) ? "lowHP_foe" : "lowHP_ally")
            end
          else
            target_triggers.push((target.pbOwnedByPlayer?) ? "lowHP" : (target.opposes?) ? "lowHP_foe" : "lowHP_ally")
            target_triggers.push((target.pbOwnedByPlayer?) ? "lowHPFinal" : (target.opposes?) ? "lowHPFinal_foe" : "lowHPFinal_ally")
          end
        elsif target.hp <= target.totalhp / 2
          if @battle.pbParty(target.index).length > @battle.pbSideSize(target.index)
            if @battle.pbAbleNonActiveCount(target.index) == 0
              target_triggers.push((target.pbOwnedByPlayer?) ? "halfHPFinal" : (target.opposes?) ? "halfHPFinal_foe" : "halfHPFinal_ally")
            else
              target_triggers.push((target.pbOwnedByPlayer?) ? "halfHP" : (target.opposes?) ? "halfHP_foe" : "halfHP_ally")
            end
          else
            target_triggers.push((target.pbOwnedByPlayer?) ? "halfHP" : (target.opposes?) ? "halfHP_foe" : "halfHP_ally")
            target_triggers.push((target.pbOwnedByPlayer?) ? "halfHPFinal" : (target.opposes?) ? "halfHPFinal_foe" : "halfHPFinal_ally")
          end
        end
      end
      @battle.scene.dx_midbattle(target.index, user.index, *target_triggers) if target_triggers.length > 0
    end
  end
end