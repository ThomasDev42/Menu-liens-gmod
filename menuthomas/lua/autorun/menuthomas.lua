THOMENU = {}

if SERVER then
  AddCSLuaFile("menuthomas/config.lua")
  include("menuthomas/config.lua")

  util.AddNetworkString("OpenMenu")
  hook.Add("PlayerInitialSpawn", "OpenMenuOnPlayerSpawn", function(player)
    net.Start("OpenMenu")
    net.Send(player)
  end)
end

if CLIENT then
  include("menuthomas/config.lua")

  local function OpenPanel()
    local Dpanel = vgui.Create("DFrame")
    Dpanel:SetSize(500, 500)
    Dpanel:Center()
    Dpanel:SetTitle("Menu De redirection")
    Dpanel:SetVisible(true)
    Dpanel:SetDraggable(true) -- Permet le déplacement du panneau
    Dpanel:ShowCloseButton(true)
    Dpanel:MakePopup()

    -- Fonction pour dessiner des panneaux arrondis
    local function RoundedBox(panel, radius, color)
      panel.Paint = function(self, w, h)
        draw.RoundedBox(radius, 0, 0, w, h, color)
      end
    end

    RoundedBox(Dpanel, 8, THOMENU.Config.Colormenu["couleuraddon"])

    local DermaButton = vgui.Create("DButton", Dpanel)
    DermaButton:SetText("Clique ici pour rejoindre le Discord !")
    DermaButton:SetSize(500, 40)
    DermaButton:SetPos(1, 61)
    DermaButton:SetMouseInputEnabled(true)
    DermaButton:SetTextColor(Color(0, 0, 0))
    DermaButton:SetFont("DermaDefaultBold")
    RoundedBox(DermaButton, 8, THOMENU.Config.Colorbutton["couleuraddon"])
    DermaButton.DoClick = function()
      gui.OpenURL(THOMENU.Config.Discord)
    end

    local DermaButton2 = vgui.Create("DButton", Dpanel)
    DermaButton2:SetText("Clique ici pour s'abonner à la collection !")
    DermaButton2:SetSize(500, 40)
    DermaButton2:SetPos(1, 122)
    DermaButton2:SetMouseInputEnabled(true)
    DermaButton2:SetTextColor(Color(0, 0, 0))
    DermaButton2:SetFont("DermaDefaultBold")
    RoundedBox(DermaButton2, 8, THOMENU.Config.Colorbutton["couleuraddon"])
    DermaButton2.DoClick = function()
      gui.OpenURL(THOMENU.Config.Collection)
    end

    local DermaButton3 = vgui.Create("DButton", Dpanel)
    DermaButton3:SetText("Clique ici pour visiter notre site web !")
    DermaButton3:SetSize(500, 40)
    DermaButton3:SetPos(1, 183)
    DermaButton3:SetMouseInputEnabled(true)
    DermaButton3:SetTextColor(Color(0, 0, 0))
    DermaButton3:SetFont("DermaDefaultBold")
    RoundedBox(DermaButton3, 8, THOMENU.Config.Colorbutton["couleuraddon"])
    DermaButton3.DoClick = function()
      gui.OpenURL(THOMENU.Config.Siteweb)
    end
  end

  hook.Add("PlayerButtonDown", "OpenMenuOnKeyPress", function(player, button)
    if button == KEY_N then
      OpenPanel()
    end
  end)

  net.Receive("OpenMenu", function()
    -- Ne fait rien ici, le panneau sera ouvert lorsque la touche "N" est pressée
  end)
end
