class Spriteset_Global
    alias rf_portraits_init initialize
    alias rf_portraits_update update

    attr_accessor :activePortrait

    def initialize
        rf_portraits_init
        @activePortrait = nil
        @oldPortrait = nil
    end

    def newPortrait(portrait, align = 0)
        @oldPortrait = @activePortrait
        @oldPortrait&.state = :closing
        @activePortrait = RfDialoguePortrait.new(portrait, align, @@viewport2)
    end

    def update
        rf_portraits_update
        @activePortrait&.update
        @oldPortrait&.update
    end

    def self.viewport
        return @@viewport2
    end
end

class RfDialoguePortrait
    attr_accessor :state
    attr_reader :portrait

    # portrait: Name of the portrait graphic in Graphics/Portraits (ANIMATED GIFS ARE NOT SUPPORTED)
    # align: 0 aligns left, 1 aligns right
    # viewport: if you don't understand what this does you probably shouldn't be creating this object yourself
    def initialize(portrait, align = 0, viewport = nil)
        @align = align
        @sprite = Sprite.new(viewport)
        @sprite.bitmap = Bitmap.new("Graphics/Portraits/#{portrait}")
        @sprite.ox = @sprite.bitmap.width * align
        @sprite.oy = @sprite.bitmap.height
        @sprite.x = align > 0 ? Graphics.width + 128 : -128
        @sprite.y = Graphics.height - 80
        @sprite.opacity = 0
        @outline = @sprite.create_outline_sprite
        @outline.opacity = 0
        @state = :opening
        @disposed = false
        rescue # nullify the bitmap if something goes wrong
        @sprite.bitmap = nil
    end

    def portrait=(portrait)
        # dispose old sprites
        @outline&.dispose
        @sprite.bitmap&.dispose
        # create new ones
        @sprite.bitmap = Bitmap.new("Graphics/Portraits/#{portrait}")
        @outline = @sprite.create_outline_sprite
        rescue # nullify the bitmap if something goes wrong
        @sprite.bitmap = nil
        @outline = nil
    end

    def update
        return if @disposed
        case @state
        when :opening
            openAnimation
        when :active
            mainUpdate
        when :closing
            closeAnimation
        else
            raise "Invalid dialogue portrait state"
        end
    end

    def openAnimation
        @sprite.opacity += 32
        @outline.opacity += 32
        if @align > 0
            @sprite.x -= 16
            @outline.x -= 16
            @state = :active if @sprite.x <= Graphics.width
        else
            @sprite.x += 16
            @outline.x += 16
            @state = :active if @sprite.x >= 0
        end
    end

    def mainUpdate
        # lip flaps would go here, however these are currently not implemented
    end

    def closeAnimation
        return if @disposed
        @sprite.opacity -= 32
        @outline.opacity -= 32
        if @align > 0
            @sprite.x += 16
            @outline.x += 16
            dispose if @sprite.x >= Graphics.width + 128
        else
            @sprite.x -= 16
            @outline.x -= 16
            dispose if @sprite.x <= -128
        end
    end

    def dispose
        @sprite.bitmap&.dispose
        @sprite.dispose
        @outline.dispose
        @disposed = true
    end

    def disposed?
        return @disposed
    end
end
