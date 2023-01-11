#===============================================================================
# "FRLG Summary Screen" plugin
# This file contains changes for miscellaneous scripts.
#===============================================================================

#===============================================================================
# Fixes some bugs in Window_AdvancedCommandPokemon
#===============================================================================
class Window_AdvancedCommandPokemon < Window_DrawableCommand
  def resizeToFit(commands, width = nil)
    dims = []
    getAutoDims(commands, dims, width)
    self.width = dims[0]
    self.height = dims[1]
  end

  def drawItem(index, _count, rect)
    pbSetSystemFont(self.contents)
    rect = drawCursor(index, rect)
    if toUnformattedText(@commands[index]).gsub(/\n/, "") == @commands[index]
      # Use faster alternative for unformatted text without line breaks
      pbDrawShadowText(self.contents, rect.x, rect.y + 8, rect.width, rect.height,
                       @commands[index], self.baseColor, self.shadowColor)
    else
      chars = getFormattedText(self.contents, rect.x, rect.y + 8, rect.width, rect.height,
                               @commands[index], rect.height, true, true)
      drawFormattedChars(self.contents, chars)
    end
  end
end

#-----------------------------------------------------------------------------
# Adding Box constraints to the Pokemon Sprite Bitmap in Summary Screen
# Constraints changed for the FRLG Summary Screen Pokemon Sprite placeholder.
#-----------------------------------------------------------------------------
class PokemonSummary_Scene
    def pbFadeInAndShow(sprites, visiblesprites = nil)
        if visiblesprites
        visiblesprites.each do |i|
            if i[1] && sprites[i[0]] && !pbDisposed?(sprites[i[0]])
            sprites[i[0]].visible = true
            end
        end
        end
        @sprites["pokemon"].constrict([192, 192]) if @sprites["pokemon"] && !defined?(EliteBattle)
        numFrames = (Graphics.frame_rate * 0.4).floor
        alphaDiff = (255.0 / numFrames).ceil
        pbDeactivateWindows(sprites) {
        (0..numFrames).each do |j|
            pbSetSpritesToColor(sprites, Color.new(0, 0, 0, ((numFrames - j) * alphaDiff)))
            (block_given?) ? yield : pbUpdateSpriteHash(sprites)
        end
        }
    end

    alias __gen8__pbChangePokemon pbChangePokemon unless method_defined?(:__gen8__pbChangePokemon)
    def pbChangePokemon
        __gen8__pbChangePokemon
        @sprites["pokemon"].constrict([192, 192]) if !defined?(EliteBattle)
    end
end