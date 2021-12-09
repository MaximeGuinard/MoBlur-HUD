      if !CLIENT then return end

      surface.CreateFont( "ElegantHUDFont", { font = "Montserrat", size = 16, weight = 0 } )
      local maxBarSize = 215

      local function DrawFillableBar( x, y, w, h, baseCol, fillCol, icon, txt )
          DrawRect( x, y, w, h, baseCol )
          DrawRect( x, y, w, h, fillCol )
      end

      local function DrawRect( x, y, w, h, col )
          surface.SetDrawColor( col )
          surface.DrawRect( x, y, w, h )
      end

      local function DrawText( msg, fnt, x, y, c, align )
          draw.SimpleText( msg, fnt, x, y, c, align and align or TEXT_ALIGN_CENTER )
      end

      local function DrawOutlinedRect( x, y, w, h, t, c )
         surface.SetDrawColor( c )
         for i = 0, t - 1 do
             surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
         end
      end

      local v = { "DarkRP_HUD", "CHudBattery", "CHudHealth" }

      hook.Add( 'HUDShouldDraw', 'HUD_HIDE_DRP', function( vs )
          if table.HasValue( v, vs ) then return false end
      end )

      hook.Add( 'HUDPaint', 'HUD_DRAW_HUD', function()
          CreateHUD()
      end )

      function GetBarSize( data )
          return ( maxBarSize / 100 ) * data < maxBarSize and ( maxBarSize / 100 ) * data or maxBarSize
      end

      function CreateHUD()

          local self = LocalPlayer()

          local bX, bY, bW, bH = 5, ScrH() - 140, 320, 110 -- The main box with shit in it
          local tX, tY, tW, tH = 5, ScrH() - 171, 205, 30 -- The title bar box (above main box)
          local mX, mY, mW, mH = 10, ScrH() - 133, 81, 78 -- The model background and model box position
          local through = Color( 150, 0, 0, 150 )
          DrawRect( tX, tY, tW, tH, Color( 44, 44, 44, 150 )  )

          local job = team.GetName( self:Team() )
          local offset = 0

          -- Legit aids
          if #job > 20 then
              offset = 4
          elseif #job > 16 then
              offset = 3.4
          elseif #job > 12 then
              offset = 3
          elseif #job >= 8 then
              offset = 1.5
          elseif #job > 4 then
              offset = -0.3
          else
              offset = -1.5
          end

          local x = 265 - ( #job ) * offset

          draw.SimpleText( self:Nick(), "ElegantHUDFont", 15, ScrH() - 157, Color( 255, 255, 255, 150 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

          local hX, hY, hW, hH = 25, ScrH() - 132, 190, 24

          local divide = -20
          local offset = 20

          DrawRect( hX - offset, hY, maxBarSize + divide / 2, hH, Color( 26, 26, 26, 150 ) )
          DrawRect( hX + divide, hY, GetBarSize( self:Health() ) - divide / 2 - offset, hH, Color( 220, 20, 60, 150 ) )
          DrawText( self:Health() > 0 and self:Health() .. "" or 0 .. "", "ElegantHUDFont", 100, hY + 4, Color( 255, 255, 255, 150 ) )

          DrawRect( hX - offset, hY + 28, maxBarSize + divide / 2, hH, Color( 26, 26, 26, 150 ) )
          DrawRect( hX + divide, hY + 28, GetBarSize( self:Armor() > 0 and self:Armor() or 0 ) - divide / 2 - offset, hH, Color( 30, 144, 255, 150 ) )
          DrawText( self:Armor() > 0 and self:Armor() .. "" or 0 .. "", "ElegantHUDFont", 100, hY + 32, Color( 255, 255, 255 ) )

          DrawRect( hX - offset, hY + 55, maxBarSize + divide / 2, hH, Color( 26, 26, 26, 150 ) )
          DrawRect( hX + divide, hY + 55, GetBarSize( 100 ) - divide / 2 - offset, hH, Color( 46, 204, 113, 150 ) )
          DrawText( ( self:getDarkRPVar( "money" ).. "€" ), "ElegantHUDFont", 100, ScrH() - 73, Color( 255, 255, 255, 150 ), TEXT_ALIGN_CENTER )

      end
