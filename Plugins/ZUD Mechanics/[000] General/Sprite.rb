#===============================================================================
# SpriteWrapper additions for Dynamax sprites.
#===============================================================================
class Sprite
  def applyDynamax(isCalyrex = false)
    if Settings::SHOW_DYNAMAX_SIZE
      self.zoom_x = self.zoom_y = 1.5
    end
    if Settings::SHOW_DYNAMAX_COLOR
      self.color = (isCalyrex) ? Settings::CALYREX_COLOR : Settings::DYNAMAX_COLOR
    end
  end
  
  def unDynamax
    self.zoom_x = 1 if self.zoom_x == 1.5
    self.zoom_y = 1 if self.zoom_y == 1.5
    if [Settings::DYNAMAX_COLOR, Settings::CALYREX_COLOR].include?(self.color)
      self.color = Color.new(0, 0, 0, 0)
    end
  end
  
  def applyDynamaxIcon(battle = false)
    if self.pokemon&.dynamax?
      if Settings::SHOW_DYNAMAX_SIZE && self.bitmap.height <= 64
        self.zoom_x = self.zoom_y = 1.5
      else
        self.zoom_x = self.zoom_y = 1
      end
      if Settings::SHOW_DYNAMAX_COLOR
        calyrex = self.pokemon.isSpecies?(:CALYREX)
        if battle
          self.color = (calyrex) ? Settings::CALYREX_COLOR : Settings::DYNAMAX_COLOR
        else
          alpha_div = (1.0 - self.color.alpha.to_f / 255.0)
          r_base  = (calyrex) ? 56  : 217
          g_base  = (calyrex) ? 160 : 29
          b_base  = (calyrex) ? 193 : 71
          r = (r_base.to_f * alpha_div).floor
          g = (g_base.to_f * alpha_div).floor 
          b = (b_base.to_f * alpha_div).floor 
          a = 128 + self.color.alpha / 2
          self.color = Color.new(r, g, b, a)
        end
      end
    else
      self.unDynamax
    end
  end
end


#===============================================================================
# BattlerSprite additions for Dynamax sprites.
#===============================================================================
class Battle::Scene::BattlerSprite < RPG::Sprite
  def applyDynamax(isCalyrex = false)
    if Settings::SHOW_DYNAMAX_SIZE
      self.zoom_x = self.zoom_y = 1.5
    end
    if Settings::SHOW_DYNAMAX_COLOR
      self.color = (isCalyrex) ? Settings::CALYREX_COLOR : Settings::DYNAMAX_COLOR
    end
  end
  
  def unDynamax
    self.zoom_x = self.zoom_y = 1
    if [Settings::DYNAMAX_COLOR, Settings::CALYREX_COLOR].include?(self.color)
      self.color = Color.new(0, 0, 0, 0)
    end
  end
end