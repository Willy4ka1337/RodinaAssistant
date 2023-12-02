---@diagnostic disable: undefined-field, need-check-nil, undefined-global

script_name('RodinaHelper')
script_author('Willy4ka')
script_version('1.0')
script_description('Helper for Rodina Role Play')

local imgui                 = require('mimgui')
local encoding              = require('encoding')                                                                                       encoding.default = 'CP1251'
local u8                    = encoding.UTF8
local sampev                = require('lib.samp.events')
local ffi                   = require('ffi')
local mimgui_blur           = require('mimgui_blur')
local faicons               = require('fAwesome6')
local hotkey                = require('rmimhotkey')
local Telegram              = require('dolbogram')
local wm                    = require('lib.windows.message')
local memory                = require('memory')
local inicfg                = require('inicfg')
local directIni             = 'rodinahelper.ini'
local ini = inicfg.load(inicfg.load({
    main = {
        autologin = false,
        password = '',
        changetab = false,
        firsttabcolor = 0xFF000000,
        twotabcolor = 0xFF000000,
        threetabcolor = 0xFF000000,
        fourtabcolor = 0xFF000000,
        blocktime = false,
        blockweather = false,
        weather = 0,
        time = 12,
        autoclick = false,
        changedialog = false,
        dialogtype = 0,
        changefov = false,
        fov = 70,
        autocar = false,
        chatcalc = false,
        infobar = false,
        dynamicfov = false,
        infoBarPosX = 0,
        infoBarPosY = 0,
        infoBarNick = true,
        infoBarId = true,
        infoBarHp = true,
        infoBarAp = true,
        infoBarLvl = true,
        infoBarPing = true,
        infoBarSkin = false,
        infoBarTime = false,
        notify = false,
        notifyTelegram = false,
        notifyVk = false,
        tgbottoken = '',
        tgbotchatid = '',
        popupblur = true,
        blurradius = 20,
        infiniterun = false,
        autobike = false,
        autopin = false,
        pinpassword = '',
        autoprizes = false
    },
    bind = {
        earmour = false,
        armour = '[]',
        emack = false,
        mask = '[]',
        eheal = false,
        heal = '[]',
        elock = false,
        lock = '[]',
        edrugs1 = false,
        drugs1 = '[]',
        edrugs2 = false,
        drugs2 = '[]',
        edrugs3 = false,
        drugs3 = '[]',
        menu = '[]',
        erepcar = false,
        repcar = '[]',
        efillcar = false,
        fillcar = '[]',
        espawncar = false,
        spawncar = '[]',
        ebarrier = false,
        barrier = '[]',
    },
    tgnotify = {
        scriptcrash = false,
        setpos = false,
        sethp = false,
        setap = false,
        givemoney = false,
        removeweapon = false,
        playercontrol = false,
        changeskin = false,
        playerdied = false,
        playerspawn = false,
        disconnect = false,
        lostconnection = false,
    },
    vknotify = {
        scriptcrash = false,
        setpos = false,
        sethp = false,
        setap = false,
        givemoney = false,
        removeweapon = false,
        playercontrol = false,
        changeskin = false,
        playerdied = false,
        playerspawn = false,
        disconnect = false,
        lostconnection = false,
    },
    autopiar = {
        chat = false,
        chatwait = 0,
        echat = '',
        s = false,
        swait = 0,
        es = '',
        c = false,
        cwait = 0,
        ec = '',
        vr = false,
        vrwait = 0,
        evr = '',
        rb = false,
        rbwait = 0,
        erb = '',
        fb = false,
        fbwait = 0,
        efb = '',
        fam = false,
        famwait = 0,
        efam = '',
        ad = false,
        adwait = 0,
        ead = '',
    }
}, directIni))
inicfg.save(ini, directIni)

local ui_meta = {
    __index = function(self, v)
        if v == "switch" then
            local switch = function()
                if self.process and self.process:status() ~= "dead" then
                    return false -- // Предыдущая анимация ещё не завершилась!
                end
                self.timer = os.clock()
                self.state = not self.state

                self.process = lua_thread.create(function()
                    local bringFloatTo = function(from, to, start_time, duration)
                        local timer = os.clock() - start_time
                        if timer >= 0.00 and timer <= duration then
                            local count = timer / (duration / 100)
                            return count * ((to - from) / 100)
                        end
                        return (timer > duration) and to or from
                    end

                    while true do wait(0)
                        local a = bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then break end
                    end
                end)
                return true -- // Состояние окна изменено!
            end
            return switch
        end
        if v == 'tr' then
            local switch = function()
                if self.process and self.process:status() ~= "dead" then
                    return false -- // Предыдущая анимация ещё не завершилась!
                end
                self.timer = os.clock()
                self.state = true

                self.process = lua_thread.create(function()
                    local bringFloatTo = function(from, to, start_time, duration)
                        local timer = os.clock() - start_time
                        if timer >= 0.00 and timer <= duration then
                            local count = timer / (duration / 100)
                            return count * ((to - from) / 100)
                        end
                        return (timer > duration) and to or from
                    end

                    while true do wait(0)
                        local a = bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then break end
                    end
                end)
                return true -- // Состояние окна изменено!
            end
            return switch
        end
        if v == 'fl' then
            local switch = function()
                if self.process and self.process:status() ~= "dead" then
                    return false -- // Предыдущая анимация ещё не завершилась!
                end
                self.timer = os.clock()
                self.state = false

                self.process = lua_thread.create(function()
                    local bringFloatTo = function(from, to, start_time, duration)
                        local timer = os.clock() - start_time
                        if timer >= 0.00 and timer <= duration then
                            local count = timer / (duration / 100)
                            return count * ((to - from) / 100)
                        end
                        return (timer > duration) and to or from
                    end

                    while true do wait(0)
                        local a = bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then break end
                    end
                end)
                return true -- // Состояние окна изменено!
            end
            return switch
        end
        if v == "alpha" then
            return self.state and 1.00 or 0.00
        end
    end
}

local imguitable = {
    renderWindow = { state = false, duration = 0.3 },
    infoBarWindow = { state = false, duration = 0.3 },
    updateWindow = { state = false, duration = 0.3 },
    calcWindow = imgui.new.bool(false),

    alogin = imgui.new.bool(ini.main.autologin),
    ctab = imgui.new.bool(ini.main.changetab),
    ctime = imgui.new.bool(ini.main.blocktime),
    cweather = imgui.new.bool(ini.main.blockweather),
    aclick = imgui.new.bool(ini.main.autoclick),
    cdialog = imgui.new.bool(ini.main.changedialog),
    cfov = imgui.new.bool(ini.main.changefov),
    cacar = imgui.new.bool(ini.main.autocar),
    cchatcalc = imgui.new.bool(ini.main.chatcalc),
    cinfobar = imgui.new.bool(ini.main.infobar),
    cdynamicfov = imgui.new.bool(ini.main.dynamicfov),
    cnotify = imgui.new.bool(ini.main.notify),
    cvknotify = imgui.new.bool(ini.main.notifyVk),
    ctgnotify = imgui.new.bool(ini.main.notifyTelegram),
    cpopupblur = imgui.new.bool(ini.main.popupblur),
    cwhatsappnotify = imgui.new.bool(false),
    cvibernotify = imgui.new.bool(false),
    cskypenotify = imgui.new.bool(false),
    cgolubinayapochtanotify = imgui.new.bool(false),
    cinfiniterun = imgui.new.bool(ini.main.infiniterun),
    cautobike = imgui.new.bool(ini.main.autobike),
    cautopin = imgui.new.bool(ini.main.autopin),
    cautoprizes = imgui.new.bool(ini.main.autoprizes),

    stime = imgui.new.int(ini.main.time),
    fov = imgui.new.int(ini.main.fov),
    ditype = imgui.new.int(ini.main.dialogtype),
    sweather = imgui.new.int(ini.main.weather),
    blurradius = imgui.new.int(ini.main.blurradius),

    carmour = imgui.new.bool(ini.bind.earmour),
    cmask = imgui.new.bool(ini.bind.emack),
    cheal = imgui.new.bool(ini.bind.eheal),
    cdrugs1 = imgui.new.bool(ini.bind.edrugs1),
    cdrugs2 = imgui.new.bool(ini.bind.edrugs2),
    cdrugs3 = imgui.new.bool(ini.bind.edrugs3),
    clock = imgui.new.bool(ini.bind.elock),
    crepcar = imgui.new.bool(ini.bind.erepcar),
    cfillcar = imgui.new.bool(ini.bind.efillcar),
    cspawncar = imgui.new.bool(ini.bind.espawncar),
    cbarrier = imgui.new.bool(ini.bind.ebarrier),

    pass = imgui.new.char[64](ini.main.password),
    pinpass = imgui.new.char[10](ini.main.pinpassword),
    tgbottoken = imgui.new.char[512](ini.main.tgbottoken),
    tgchatid = imgui.new.char[64](tostring(ini.main.tgbotchatid)),

    cinfoBarNick = imgui.new.bool(ini.main.infoBarNick),
    cinfoBarId = imgui.new.bool(ini.main.infoBarId),
    cinfoBarHp = imgui.new.bool(ini.main.infoBarHp),
    cinfoBarAp = imgui.new.bool(ini.main.infoBarAp),
    cinfoBarLvl = imgui.new.bool(ini.main.infoBarLvl),
    cinfoBarPing = imgui.new.bool(ini.main.infoBarPing),
    cinfoBarSkin = imgui.new.bool(ini.main.infoBarSkin),
    cinfoBarTime = imgui.new.bool(ini.main.infoBarTime),

    tgscriptcrash = imgui.new.bool(ini.tgnotify.scriptcrash),
    tgsetpos = imgui.new.bool(ini.tgnotify.setpos),
    tgsethp = imgui.new.bool(ini.tgnotify.sethp),
    tgsetap = imgui.new.bool(ini.tgnotify.setap),
    tggivemoney = imgui.new.bool(ini.tgnotify.givemoney),
    tgremoveweapon = imgui.new.bool(ini.tgnotify.removeweapon),
    tgplayercontrol = imgui.new.bool(ini.tgnotify.playercontrol),
    tgchangeskin = imgui.new.bool(ini.tgnotify.changeskin),
    tgplayerdied = imgui.new.bool(ini.tgnotify.playerdied),
    tgplayerspawn = imgui.new.bool(ini.tgnotify.playerspawn),
    tglostconnection = imgui.new.bool(ini.tgnotify.lostconnection),
    tgdisconnect = imgui.new.bool(ini.tgnotify.disconnect),

    cautopiar = imgui.new.bool(false),
    cpiarchat = imgui.new.bool(ini.autopiar.chat),
    cpiars = imgui.new.bool(ini.autopiar.s),
    cpiarc = imgui.new.bool(ini.autopiar.c),
    cpiarvr = imgui.new.bool(ini.autopiar.vr),
    cpiarrb = imgui.new.bool(ini.autopiar.rb),
    cpiarfb = imgui.new.bool(ini.autopiar.fb),
    cpiarfam = imgui.new.bool(ini.autopiar.fam),
    cpiarad = imgui.new.bool(ini.autopiar.ad),

    wpiarchat = imgui.new.int(ini.autopiar.chatwait),
    wpiars = imgui.new.int(ini.autopiar.swait),
    wpiarc = imgui.new.int(ini.autopiar.cwait),
    wpiarvr = imgui.new.int(ini.autopiar.vrwait),
    wpiarrb = imgui.new.int(ini.autopiar.rbwait),
    wpiarfb = imgui.new.int(ini.autopiar.fbwait),
    wpiarfam = imgui.new.int(ini.autopiar.famwait),
    wpiarad = imgui.new.int(ini.autopiar.adwait),

    epiarchat = imgui.new.char[128](ini.autopiar.echat),
    epiars = imgui.new.char[128](ini.autopiar.es),
    epiarc = imgui.new.char[128](ini.autopiar.ec),
    epiarvr = imgui.new.char[128](ini.autopiar.evr),
    epiarrb = imgui.new.char[128](ini.autopiar.erb),
    epiarfb = imgui.new.char[128](ini.autopiar.efb),
    epiarfam = imgui.new.char[128](ini.autopiar.efam),
    epiarad = imgui.new.char[128](ini.autopiar.ead),
}

local inputhotkeyname = imgui.new.char[64]()
local inputhotkeywait = imgui.new.int()
local inputhotkeytext = imgui.new.char[256]()
local inputhotkeycef = imgui.new.char[256]()
local bindsendtype = imgui.new.int(1)
local btypes = {
    'Chat',
    'CEF',
}

setmetatable(imguitable.renderWindow, ui_meta)
setmetatable(imguitable.infoBarWindow, ui_meta)
setmetatable(imguitable.updateWindow, ui_meta)

local bot = nil
if ini.main.tgbottoken:len()>0 then
    bot = Telegram(ini.main.tgbottoken)
    bot:connect()
end
if bot ~= nil then
    bot:on('ready', function(data)
        while not isSampAvailable() do wait(100) end
        msg('[Telegram Notifications] Бот успешно запустился! Имя: '..data.first_name)
    end)
end

local changeinfobarpos = false
local hidemenu = false
local kkkk = nil

local binds = {
    armour = {
        name = 'armour',
        keys = decodeJson(ini.bind.armour),
        callback = function()
            if imguitable.carmour[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/armour')
            end
        end,
    },
    mask = {
        name = 'mask',
        keys = decodeJson(ini.bind.mask),
        callback = function()
            if imguitable.cmask[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/mask')
            end
        end,
    },
    heal = {
        name = 'heal',
        keys = decodeJson(ini.bind.heal),
        callback = function()
            if imguitable.cheal[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/usemed')
            end
        end,
    },
    lock = {
        name = 'lock',
        keys = decodeJson(ini.bind.lock),
        callback = function()
            if imguitable.clock[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/lock')
            end
        end,
    },
    drugs1 = {
        name = 'drugs1',
        keys = decodeJson(ini.bind.drugs1),
        callback = function()
            if imguitable.cdrugs1[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/usedrugs 1')
            end
        end,
    },
    drugs2 = {
        name = 'drugs2',
        keys = decodeJson(ini.bind.drugs2),
        callback = function()
            if imguitable.cdrugs2[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/usedrugs 2')
            end
        end,
    },
    drugs3 = {
        name = 'drugs3',
        keys = decodeJson(ini.bind.drugs3),
        callback = function()
            if imguitable.cdrugs3[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/usedrugs 3')
            end
        end,
    },
    repcar = {
        name = 'repcar',
        keys = decodeJson(ini.bind.repcar),
        callback = function()
            if imguitable.crepcar[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/repcar')
            end
        end,
    },
    fillcar = {
        name = 'fillcar',
        keys = decodeJson(ini.bind.fillcar),
        callback = function()
            if imguitable.cfillcar[0] and not sampIsCursorActive() and not isCursorActive() then
                sampSendChat('/fillcar')
            end
        end,
    },
    spawncar = {
        name = 'spawncar',
        keys = decodeJson(ini.bind.spawncar),
        callback = function()
            if imguitable.cspawncar[0] and not sampIsCursorActive() and not isCursorActive() then
                if isCharInAnyCar(PLAYER_PED) then
                    local car = storeCarCharIsInNoSave(PLAYER_PED)
                    local result, id = sampGetVehicleIdByCarHandle(car)
                    if result then
                        sampSendChat('/fixmycar '..id)
                    end
                end
            end
        end,
    },
    barrier = {
        name = 'barrier',
        keys = decodeJson(ini.bind.barrier),
        callback = function()
            if imguitable.cbarrier[0] and not sampIsCursorActive() and not isCursorActive() then
                if isCharInAnyCar(PLAYER_PED) then
                    sampSendChat('/open')
                end
            end
        end,
    },
    menu = {
        name = 'menu',
        keys = decodeJson(ini.bind.menu),
        callback = function()
            if not sampIsCursorActive() then
                imguitable.renderWindow.switch()
            end
        end,
    },
    createbind = {
        name = 'createbind',
        keys = decodeJson('[]'),
        callback = function() end
    },
    editbind = {
        name = 'editbind',
        keys = decodeJson('[]'),
        callback = function() end
    },
}
local cusbinds = {}
local actual = {
	time = memory.getint8(0xB70153),
	weather = memory.getint16(0xC81320)
}
local list = {
    icons = {
        'USER',
        'CAR_SIDE',
        'PEN',
        'BOLT',
        'COMMENT',
        'PALETTE',
        'GEAR',
        'QUESTION',
    },
    name = {
        'Персонаж',
        'Транспорт',
        'Биндер',
        'Прочее',
        'Уведомления',
        'Кастомизация',
        'Настройки',
        'Информация',
    },
}
local tabs = {
    maintab = 1,
    notifytab = 1,
}
local updates = {
    ver = nil,
    date = nil,
    changes = nil
}
local chatcalcresult, ok, number = nil, nil, nil

imgui.OnInitialize(function()
    imgui.DarkTheme()
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('regular'), 14, config, iconRanges)
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    arialtext = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\Arial.ttf', 24, _, glyph_ranges)
    local color1 = imgui.ColorConvertU32ToFloat4(ini.main.firsttabcolor)
    local color2 = imgui.ColorConvertU32ToFloat4(ini.main.twotabcolor)
    local color3 = imgui.ColorConvertU32ToFloat4(ini.main.threetabcolor)
    local color4 = imgui.ColorConvertU32ToFloat4(ini.main.fourtabcolor)
    ctabone = imgui.new.float[4](color1.x,color1.y,color1.z,color1.w)
    ctabtwo = imgui.new.float[4](color2.x,color2.y,color2.z,color2.w)
    ctabthree = imgui.new.float[4](color3.x,color3.y,color3.z,color3.w)
    ctabfour = imgui.new.float[4](color4.x,color4.y,color4.z,color4.w)
end)

function main()
    while not isSampAvailable() do wait(0) end
    if ini.main.infobar then
        imguitable.infoBarWindow.tr()
    end
    if not doesDirectoryExist(getWorkingDirectory()..'\\RodinaHelper') then createDirectory(getWorkingDirectory()..'\\RodinaHelper') end
    if not doesFileExist(getWorkingDirectory()..'\\RodinaHelper\\binds.txt') then local cfile = io.open(getWorkingDirectory()..'\\RodinaHelper\\binds.txt', 'w'); cfile:write(''); cfile:close() end
    LoadBinds()
    sampRegisterChatCommand('rhelp', imguitable.renderWindow.switch)
    sampRegisterChatCommand('upd', imguitable.updateWindow.switch)
    for k,v in pairs(binds) do
        hotkey.RegisterCallback(v.name, v.keys, v.callback)
    end
    if imguitable.cdialog[0] then
        dialogstyle(imguitable.ditype[0])
    end
    checkupdate()
    msg('Скрипт успешно загружен! Открыть меню: /rhelp')
    while true do
        wait(0)
        if imguitable.cfov[0] then
            cameraSetLerpFov(imguitable.fov[0], imguitable.fov[0], 1000, 1)
        end
        if imguitable.cdynamicfov[0] and not imguitable.cfov[0] then
            if not isCharInAnyCar(PLAYER_PED) then
                local m = {getCharCoordinates(PLAYER_PED)}
                local f = {getActiveCameraCoordinates()}
                local camfov = 70+((m[3]+1.5-f[3])*15)
                if camfov < 70 then camfov = 70 end
                if camfov > 105 then camfov = 105 end
                cameraSetLerpFov(camfov, camfov, 1000, 1)
            else
                local car = storeCarCharIsInNoSave(PLAYER_PED)
                local c = {getCarCoordinates(car)}
                local f = {getActiveCameraCoordinates()}
                local speed = getCarSpeed(car)
                local camfov = 70+((c[3]+1.5-f[3])*7)
                camfov = camfov+(speed)
                if camfov < 70 then camfov = 70 end
                if camfov > 115 then camfov = 115 end
                cameraSetLerpFov(camfov, camfov, 1000, 1)
            end
        end
        if imguitable.ctab[0] then
            setTabColor(argb2abgr(ini.main.firsttabcolor), argb2abgr(ini.main.twotabcolor), argb2abgr(ini.main.threetabcolor), argb2abgr(ini.main.fourtabcolor))
        end
        if imguitable.cchatcalc[0] then
            local text = sampGetChatInputText()
            if text:find('%d+') and text:find('[-+/*^%%]') and not text:find('%a+') and text ~= nil then
                ok, number = pcall(load('return '..text))
                chatcalcresult = 'Результат: '..number
            end
            if text:find('%d+%%%*%d+') then
                local number1, number2 = text:match('(%d+)%%%*(%d+)')
                number = number1*number2/100
                ok, number = pcall(load('return '..number))
                chatcalcresult = 'Результат: '..number
            end
            if text:find('%d+%%%/%d+') then
                local number1, number2 = text:match('(%d+)%%%/(%d+)')
                number = number2/number1*100
                ok, number = pcall(load('return '..number))
                chatcalcresult = 'Результат: '..number
            end
            if text:find('%d+/%d+%%') then
                local number1, number2 = text:match('(%d+)/(%d+)%%')
                number = number1*100/number2
                ok, number = pcall(load('return '..number))
                chatcalcresult = 'Результат: '..number..'%'
            end
            if text == '' then
                ok = false
            end
            if ok ~= nil then
                imguitable.calcWindow[0] = ok
            end
        end
        if changeinfobarpos then
            ini.main.infoBarPosX, ini.main.infoBarPosY = getCursorPos()
        end
        if imguitable.cinfiniterun[0] then
            memory.setint8(0xB7CEE4, 1)
        end
    end
end

lua_thread.create(function()
    local bikes = {
        481,
        509,
        510
    }
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            
            
            
            
            
            
            
        end
        if imguitable.cautobike[0] then
            if isCharOnAnyBike(PLAYER_PED) then
                for k,v in pairs(bikes) do
                    local veh = storeCarCharIsInNoSave(PLAYER_PED)
                    local modelId = getCarModel(veh)
                    if modelId == v then
                        if isKeyDown(0x10) then
                            setGameKeyState(16, 255)
                            wait(10)
                            setGameKeyState(16, 0)
                        end
                    else
                        if isKeyDown(0x10) then
                            setGameKeyState(1, -128)
                            wait(50)
                            setGameKeyState(1, 0)
                        end
                    end
                end
            end
        end
    end
end)

lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarchat[0] then
                sampSendChat(u8d(ffi.string(imguitable.epiarchat)))
                wait(imguitable.wpiarchat[0])
            end
        end
    end
end)

lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiars[0] then
                sampSendChat('/s '..u8d(ffi.string(imguitable.epiars)))
                wait(imguitable.wpiars[0])
            end
        end
    end
end)
lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarc[0] then
                sampSendChat('/c '..u8d(ffi.string(imguitable.epiarc)))
                wait(imguitable.wpiarc[0])
            end
        end
    end
end)
lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarvr[0] then
                sampSendChat('/vr '..u8d(ffi.string(imguitable.epiarvr)))
                wait(imguitable.wpiarvr[0])
            end
        end
    end
end)
lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarrb[0] then
                sampSendChat('/rb '..u8d(ffi.string(imguitable.epiarrb)))
                wait(imguitable.wpiarrb[0])
            end
        end
    end
end)
lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarfb[0] then
                sampSendChat('/fb '..u8d(ffi.string(imguitable.epiarfb)))
                wait(imguitable.wpiarfb[0])
            end
        end
    end
end)
lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarfam[0] then
                sampSendChat('/fam '..u8d(ffi.string(imguitable.epiarfam)))
                wait(imguitable.wpiarfam[0])
            end
        end
    end
end)
lua_thread.create(function ()
    while true do
        wait(0)
        if imguitable.cautopiar[0] then
            if imguitable.cpiarad[0] then
                sampSendChat('/ad 1 '..u8d(ffi.string(imguitable.epiarad)))
                wait(imguitable.wpiarad[0])
            end
        end
    end
end)
imgui.OnFrame(
    function() return imguitable.renderWindow.alpha>0.00 end,
    function(self)
        self.HideCursor = hidemenu or (not imguitable.renderWindow.state)
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, imguitable.renderWindow.alpha)
        local resX, resY = getScreenResolution()
        local sizeX, sizeY = 700, 400
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        if imgui.Begin('Rodina Helper', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar) then
            imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
            imgui.CenterText('Rodina Helper')
            imgui.SameLine(imgui.GetWindowSize().x-30)
            imgui.SetCursorPosY(imgui.GetCursorPosY()-5)
            if imgui.Button(faicons['CIRCLE_XMARK'], imgui.ImVec2(-1,23.5)) then
                imguitable.renderWindow.fl()
            end
            imgui.Separator()
            if imgui.BeginChild('##List', imgui.ImVec2(200, -1), true, imgui.WindowFlags.NoScrollbar) then
                for k, v in pairs(list.name) do
                    if imgui.GradientPB(tabs.maintab == k, faicons(list.icons[k]), v, 0.50, imgui.ImVec2(imgui.GetWindowSize().x-10, 35)) then
                        tabs.maintab = k
                    end
                end
                imgui.SetCursorPosX(10)
                imgui.SetCursorPosY(imgui.GetWindowSize().y-20)
                imgui.Link('https://www.blast.hk/members/413482/','by Willy4ka')
                imgui.EndChild()
            end
            imgui.SameLine()
            imgui.BeginChild('##Functions', imgui.ImVec2(485, -1), true, imgui.WindowFlags.NoScrollbar)
                textbg()
                if tabs.maintab == 1 then -- ПЕРСОНАЖ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Персонаж')
                    imgui.Separator()
                    imgui.BeginChild('##PLeft', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##armour', imguitable.carmour) then
                        ini.bind.earmour = imguitable.carmour[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keyarmour = hotkey.KeyEditor('armour', 'Бронежилет', imgui.ImVec2(185, 24))
                    if keyarmour then
                        ini.bind.armour = encodeJson(keyarmour)
                        inicfg.save(ini, directIni)
                    end

                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##heal', imguitable.cheal) then
                        ini.bind.eheal = imguitable.cheal[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keyheal = hotkey.KeyEditor('heal', 'Аптечка', imgui.ImVec2(185, 24))
                    if keyheal then
                        ini.bind.heal = encodeJson(keyheal)
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##mask', imguitable.cmask) then
                        ini.bind.emack = imguitable.cmask[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keymask = hotkey.KeyEditor('mask', 'Маска', imgui.ImVec2(185, 24))
                    if keymask then
                        ini.bind.mask = encodeJson(keymask)
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##grugs1', imguitable.cdrugs1) then
                        ini.bind.edrugs1 = imguitable.cdrugs1[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keydrugs1 = hotkey.KeyEditor('drugs1', 'Наркотики (1 шт)', imgui.ImVec2(185, 24))
                    if keydrugs1 then
                        ini.bind.drugs1 = encodeJson(keydrugs1)
                        inicfg.save(ini, directIni)
                    end

                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##grugs2', imguitable.cdrugs2) then
                        ini.bind.edrugs2 = imguitable.cdrugs2[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keydrugs2 = hotkey.KeyEditor('drugs2', 'Наркотики (2 шт)', imgui.ImVec2(185, 24))
                    if keydrugs2 then
                        ini.bind.drugs2 = encodeJson(keydrugs2)
                        inicfg.save(ini, directIni)
                    end

                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##grugs3', imguitable.cdrugs3) then
                        ini.bind.edrugs3 = imguitable.cdrugs3[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keydrugs3 = hotkey.KeyEditor('drugs3', 'Наркотики (3 шт)', imgui.ImVec2(185, 24))
                    if keydrugs3 then
                        ini.bind.drugs3 = encodeJson(keydrugs3)
                        inicfg.save(ini, directIni)
                    end
                    imgui.EndChild()
                    imgui.SameLine()
                    imgui.BeginChild('##PRight', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox(('Бесконечный бег'), imguitable.cinfiniterun) then
                        ini.main.infiniterun = imguitable.cinfiniterun[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.EndChild()
                elseif tabs.maintab == 2 then -- ТРАНСПОРТ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Транспорт')
                    imgui.Separator()
                    imgui.BeginChild('##CLeft', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##lock', imguitable.clock) then
                        ini.bind.elock = imguitable.clock[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keylock = hotkey.KeyEditor('lock', 'Закрытие транспорта', imgui.ImVec2(185, 24))
                    if keylock then
                        ini.bind.lock = encodeJson(keylock)
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##repcar', imguitable.crepcar) then
                        ini.bind.erepcar = imguitable.crepcar[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keyrep = hotkey.KeyEditor('repcar', 'Починка траснспорта', imgui.ImVec2(185, 24))
                    if keyrep then
                        ini.bind.repcar = encodeJson(keyrep)
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##fillcar', imguitable.cfillcar) then
                        ini.bind.efillcar = imguitable.cfillcar[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keyfill = hotkey.KeyEditor('fillcar', 'Заправка траснспорта', imgui.ImVec2(185, 24))
                    if keyfill then
                        ini.bind.fillcar = encodeJson(keyfill)
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##spawncar', imguitable.cspawncar) then
                        ini.bind.espawncar = imguitable.cspawncar[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keyspawn = hotkey.KeyEditor('spawncar', 'Спавн траснспорта', imgui.ImVec2(185, 24))
                    if keyspawn then
                        ini.bind.spawncar = encodeJson(keyspawn)
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('##barrier', imguitable.cbarrier) then
                        ini.bind.ebarrier = imguitable.cbarrier[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosY(imgui.GetCursorPosY()-2)
                    local keybarrier = hotkey.KeyEditor('barrier', 'Открытие шлагбаума', imgui.ImVec2(185, 24))
                    if keybarrier then
                        ini.bind.barrier = encodeJson(keybarrier)
                        inicfg.save(ini, directIni)
                    end
                    imgui.EndChild()
                    imgui.SameLine()
                    imgui.BeginChild('##CRight', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('AutoCar', imguitable.cacar) then
                        ini.main.autocar = imguitable.cacar[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('hcar', 'При посадке в транспорт автоматически\nзакрывает двери, заводит двигатель и пристегивается')
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Moto/Bike Flood', imguitable.cautobike) then
                        ini.main.autobike = imguitable.cautobike[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('mbflood', 'На велосипеде/мотоцикле при зажатии SHIFT\nбудет развиваться максимальная скорость')
                    imgui.EndChild()
                elseif tabs.maintab == 3 then --БИНДЕР
                    -- БЛЯТЬ, НЕ СМОТРИ СЮДА СЮДА ПОЖАЛУЙСТА, Я САМ НЕ ЕБУ ЧЕ ЗА ХУЙНЮ Я ТУТ ВЫСРАЛ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Биндер')
                    imgui.Separator()
                    if imgui.Button('Создать бинд', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                        hotkey.RegisterCallback('createbind', decodeJson('[]'), function() end)
                        imgui.OpenPopup('Создание бинда')
                    end
                    if imgui.BeginPopupModal('Создание бинда', _, imgui.WindowFlags.NoResize) then
                        if imguitable.cpopupblur[0] then mimgui_blur.apply(imgui.GetBackgroundDrawList(), imguitable.blurradius[0]) end
                        imgui.SetWindowSizeVec2(imgui.ImVec2(350, -1))
                        imgui.CenterText('НАЗВАНИЕ БИНДА НЕ ДОЛЖНО ПОВТОРЯТЬСЯ')
                        imgui.CenterText('И НЕ ИМЕТЬ РУССКИХ БУКВ')
                        imgui.PushItemWidth(-1)
                        imgui.InputTextWithHint('##Bind name', 'Введите название бинда', inputhotkeyname, ffi.sizeof(inputhotkeyname))
                        if not getItemByName((ffi.string(inputhotkeyname))) then imgui.Hint('bindname', 'ОШИБКА! БИНД С ЭТИМ НАЗВАНИЕМ УЖЕ СУЩЕСТВУЕТ!') end
                        local cbind = hotkey.KeyEditor('createbind', 'Клавиша', imgui.ImVec2(-1, 24))
                        if encodeJson(cbind) ~= 'null' then
                            kkkk = encodeJson(cbind)
                        end
                        imgui.ItemSelector('Тип отправки', btypes, bindsendtype)
                        if bindsendtype[0] == 1 then
                            imgui.CenterText('Задержка')
                            imgui.InputInt('##wait', inputhotkeywait, 100)
                            imgui.InputTextMultiline('##inputbind',inputhotkeytext,ffi.sizeof(inputhotkeytext))
                            if ffi.string(inputhotkeyname):len() > 0 and not (ffi.string(inputhotkeyname)):find('[А-Яа-я]') and getItemByName((ffi.string(inputhotkeyname))) and kkkk and (ffi.string(inputhotkeytext)):len()>0 and ffi.string(inputhotkeycef):len() >= 0 and not (ffi.string(inputhotkeycef)):find('[А-Яа-я]') then
                                if imgui.Button('Сохранить', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                                    table.insert(cusbinds, {
                                        [ffi.string(inputhotkeyname)] = {
                                            name = (ffi.string(inputhotkeyname)),
                                            keys = kkkk,
                                            wait = inputhotkeywait[0],
                                            sendtype = bindsendtype[0],
                                            text = (ffi.string(inputhotkeytext)),
                                            sendcef = ffi.string(inputhotkeycef),
                                            callback = function()
                                                if not sampIsCursorActive() and not isCursorActive() then
                                                    lua_thread.create(function ()
                                                        if bindsendtype[0] == 1 then
                                                            for l in (ffi.string(inputhotkeytext)):gmatch("[^\r\n]+") do
                                                                sampSendChat(u8d(l))
                                                                wait(tonumber(inputhotkeywait[0]))
                                                            end
                                                        elseif bindsendtype[0] == 2 then
                                                            cef(ffi.string(inputhotkeycef))
                                                        end
                                                    end)
                                                end
                                            end,
                                        }
                                    })
                                    hotkey.RegisterCallback('createbind', decodeJson('[]'), function() end)
                                    SaveBind()
                                    inputhotkeyname = imgui.new.char[64]()
                                    inputhotkeytext = imgui.new.char[64]()
                                    inputhotkeywait = imgui.new.int()
                                    bindsendtype = imgui.new.int(1)
                                    inputhotkeycef = imgui.new.char[265]()
                                    kkkk = '[]'
                                    cbind = nil
                                    imgui.CloseCurrentPopup()
                                end
                            end
                        elseif bindsendtype[0] == 2 then
                            imgui.InputTextWithHint('##CEFEvent', 'Введите отправляемые данные CEF', inputhotkeycef, ffi.sizeof(inputhotkeycef))
                            if ffi.string(inputhotkeyname):len() > 0 and not (ffi.string(inputhotkeyname)):find('[А-Яа-я]') and getItemByName((ffi.string(inputhotkeyname))) and kkkk and (ffi.string(inputhotkeytext)):len()>=0 and ffi.string(inputhotkeycef):len() > 0 and not (ffi.string(inputhotkeycef)):find('[А-Яа-я]') then
                                if imgui.Button('Сохранить', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                                    table.insert(cusbinds, {
                                        [ffi.string(inputhotkeyname)] = {
                                            name = (ffi.string(inputhotkeyname)),
                                            keys = kkkk,
                                            wait = inputhotkeywait[0],
                                            sendtype = bindsendtype[0],
                                            text = (ffi.string(inputhotkeytext)),
                                            sendcef = ffi.string(inputhotkeycef),
                                            callback = function()
                                                if not sampIsCursorActive() and not isCursorActive() then
                                                    lua_thread.create(function ()
                                                        if bindsendtype[0] == 1 then
                                                            for l in (ffi.string(inputhotkeytext)):gmatch("[^\r\n]+") do
                                                                sampSendChat(l)
                                                                wait(tonumber(inputhotkeywait[0]))
                                                            end
                                                        elseif bindsendtype[0] == 2 then
                                                            cef(ffi.string(inputhotkeycef))
                                                        end
                                                    end)
                                                end
                                            end,
                                        }
                                    })
                                    hotkey.RegisterCallback('createbind', decodeJson('[]'), function() end)
                                    SaveBind()
                                    inputhotkeyname = imgui.new.char[64]()
                                    inputhotkeytext = imgui.new.char[64]()
                                    inputhotkeywait = imgui.new.int()
                                    bindsendtype = imgui.new.int(1)
                                    inputhotkeycef = imgui.new.char[265]()
                                    kkkk = '[]'
                                    cbind = nil
                                    imgui.CloseCurrentPopup()
                                end
                            end
                        end
                        if imgui.Button('Закрыть', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                            kkkk = '[]'
                            imgui.CloseCurrentPopup()
                        end
                        imgui.End()
                    end
                    for k, v in pairs(cusbinds) do
                        for key, value in pairs(v) do
                            if imgui.Button(faicons("TRASH").."##"..(value.name), imgui.ImVec2(50, 25)) then
                                table.remove(cusbinds, k)
                                hotkey.RegisterCallback(value.name, decodeJson('[]'), function() end)
                                SaveBind()
                            end
                            imgui.Hint('deletebind', 'Удалить')
                            imgui.SameLine()
                            imgui.Button((value.name), imgui.ImVec2(imgui.GetWindowSize().x-120, 25))
                            imgui.SameLine()
                            if imgui.Button(faicons("PENCIL").."##"..(value.name), imgui.ImVec2(50, 25)) then
                                imgui.OpenPopup('Редактирование бинда')
                                hotkey.RegisterCallback('editbind', decodeJson(value.keys), function() end)
                                inputhotkeyname = imgui.new.char[64]((value.name))
                                inputhotkeytext = imgui.new.char[64]((value.text))
                                inputhotkeywait = imgui.new.int(value.wait)
                                bindsendtype = imgui.new.int(value.sendtype)
                                inputhotkeycef = imgui.new.char[265](value.sendcef)
                            end
                            imgui.Hint('edbind', 'Изменить')
                        end
                    end
                    if imgui.BeginPopupModal('Редактирование бинда', _, imgui.WindowFlags.NoResize) then
                        if imguitable.cpopupblur[0] then mimgui_blur.apply(imgui.GetBackgroundDrawList(), imguitable.blurradius[0]) end
                        imgui.SetWindowSizeVec2(imgui.ImVec2(350, -1))
                        imgui.PushItemWidth(-1)
                        local cbind = hotkey.KeyEditor('editbind', 'Клавиша', imgui.ImVec2(-1, 24))
                        if encodeJson(cbind) ~= 'null' then
                            kkkk = encodeJson(cbind)
                        end
                        imgui.ItemSelector('Тип отправки', btypes, bindsendtype)
                        if bindsendtype[0] == 1 then
                            imgui.CenterText('Задержка')
                            imgui.InputInt('##wait', inputhotkeywait,100)
                            imgui.InputTextMultiline('##inputbind',inputhotkeytext,ffi.sizeof(inputhotkeytext))
                            if kkkk and (ffi.string(inputhotkeytext)):len()>0 and ffi.string(inputhotkeycef):len() >= 0 and not (ffi.string(inputhotkeycef)):find('[А-Яа-я]') then
                                if imgui.Button('Сохранить', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                                    local tblkey = nil
                                    for k, v in pairs(cusbinds) do
                                        for key, value in pairs(v) do
                                            if tostring(key) == ffi.string(inputhotkeyname) then
                                                tblkey = k
                                            end
                                        end
                                    end
                                    table.remove(cusbinds,tblkey)
                                    table.insert(cusbinds, {
                                        [ffi.string(inputhotkeyname)] = {
                                            name = (ffi.string(inputhotkeyname)),
                                            keys = kkkk,
                                            wait = inputhotkeywait[0],
                                            sendtype = bindsendtype[0],
                                            text = (ffi.string(inputhotkeytext)),
                                            sendcef = ffi.string(inputhotkeycef),
                                            callback = function()
                                                if not sampIsCursorActive() and not isCursorActive() then
                                                    lua_thread.create(function ()
                                                        if bindsendtype[0] == 1 then
                                                            for l in (ffi.string(inputhotkeytext)):gmatch("[^\r\n]+") do
                                                                sampSendChat(u8d(l))
                                                                wait(tonumber(inputhotkeywait[0]))
                                                            end
                                                        elseif bindsendtype[0] == 2 then
                                                            cef(ffi.string(inputhotkeycef))
                                                        end
                                                    end)
                                                end
                                            end,
                                        }
                                    })
                                    hotkey.RegisterCallback('editbind', decodeJson('[]'), function() end)
                                    SaveBind()
                                    inputhotkeyname = imgui.new.char[64]()
                                    inputhotkeytext = imgui.new.char[64]()
                                    inputhotkeywait = imgui.new.int()
                                    bindsendtype = imgui.new.int(1)
                                    inputhotkeycef = imgui.new.char[265]()
                                    kkkk = '[]'
                                    cbind = nil
                                    imgui.CloseCurrentPopup()
                                end
                            end
                        elseif bindsendtype[0] == 2 then
                            imgui.InputTextWithHint('##CEFEvent', 'Введите отправляемые данные CEF', inputhotkeycef, ffi.sizeof(inputhotkeycef))
                            if kkkk and (ffi.string(inputhotkeytext)):len()>=0 and ffi.string(inputhotkeycef):len() > 0 and not (ffi.string(inputhotkeycef)):find('[А-Яа-я]') then
                                if imgui.Button('Сохранить', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                                    local tblkey = nil
                                    for k, v in pairs(cusbinds) do
                                        for key, value in pairs(v) do
                                            if tostring(key) == ffi.string(inputhotkeyname) then
                                                tblkey = k
                                            end
                                        end
                                    end
                                    table.remove(cusbinds,tblkey)
                                    table.insert(cusbinds, {
                                        [ffi.string(inputhotkeyname)] = {
                                            name = (ffi.string(inputhotkeyname)),
                                            keys = kkkk,
                                            wait = inputhotkeywait[0],
                                            sendtype = bindsendtype[0],
                                            text = (ffi.string(inputhotkeytext)),
                                            sendcef = ffi.string(inputhotkeycef),
                                            callback = function()
                                                if not sampIsCursorActive() and not isCursorActive() then
                                                    lua_thread.create(function ()
                                                        if bindsendtype[0] == 1 then
                                                            for l in (ffi.string(inputhotkeytext)):gmatch("[^\r\n]+") do
                                                                sampSendChat(u8d(l))
                                                                wait(tonumber(inputhotkeywait[0]))
                                                            end
                                                        elseif bindsendtype[0] == 2 then
                                                            cef(ffi.string(inputhotkeycef))
                                                        end
                                                    end)
                                                end
                                            end,
                                        }
                                    })
                                    hotkey.RegisterCallback('editbind', decodeJson('[]'), function() end)
                                    SaveBind()
                                    inputhotkeyname = imgui.new.char[64]()
                                    inputhotkeytext = imgui.new.char[64]()
                                    inputhotkeywait = imgui.new.int()
                                    bindsendtype = imgui.new.int(1)
                                    inputhotkeycef = imgui.new.char[265]()
                                    kkkk = '[]'
                                    cbind = nil
                                    imgui.CloseCurrentPopup()
                                end
                            end
                        end
                        if imgui.Button('Закрыть', imgui.ImVec2(imgui.GetWindowSize().x-10, 30)) then
                            inputhotkeyname = imgui.new.char[64]()
                            inputhotkeytext = imgui.new.char[64]()
                            inputhotkeywait = imgui.new.int()
                            kkkk = '[]'
                            cbind = nil
                            imgui.CloseCurrentPopup()
                        end
                        imgui.End()
                    end
                elseif tabs.maintab == 4 then --ПРОЧЕЕ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Прочее')
                    imgui.Separator()
                    imgui.BeginChild('##OLeft', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Автологин', imguitable.alogin) then
                        ini.main.autologin = imguitable.alogin[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('autologin', 'При заходе на сервер пароль будет вводиться автоматически')
                    if imguitable.alogin[0] then
                        if imgui.CustomInput('Пароль', 'Введите пароль', imguitable.pass, ffi.sizeof(imguitable.pass), imgui.InputTextFlags.Password, 170) then
                            ini.main.password = ffi.string(imguitable.pass)
                            inicfg.save(ini, directIni)
                        end
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Авто-кликер на ресурсах', imguitable.aclick) then
                        ini.main.autoclick = imguitable.aclick[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('autoclicker', 'При сборке ресурсов ЛКМ будет нажиматься автоматически')
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Авто пин-код', imguitable.cautopin) then
                        ini.main.autopin = imguitable.cautopin[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('autopin', 'Автоматически вводит пин код в банке')
                    if imguitable.cautopin[0] then
                        if imgui.CustomInput('Код', 'Введите код', imguitable.pinpass, ffi.sizeof(imguitable.pinpass), imgui.InputTextFlags.Password, 170) then
                            ini.main.pinpassword = ffi.string(imguitable.pinpass)
                            inicfg.save(ini, directIni)
                        end
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Авто сбор /dw_prizes', imguitable.cautoprizes) then
                        ini.main.autoprizes = imguitable.cautoprizes[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.EndChild()
                    imgui.SameLine()
                    imgui.BeginChild('##ORight', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Chat Calculator', imguitable.cchatcalc) then
                        ini.main.chatcalc = imguitable.cchatcalc[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('chatcalc', 'Введите пример в чате (1+1)')
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Info Bar', imguitable.cinfobar) then
                        if imguitable.cinfobar[0] then
                            imguitable.infoBarWindow.tr()
                        else
                            imguitable.infoBarWindow.fl()
                        end
                        ini.main.infobar = imguitable.cinfobar[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    if imgui.ItemSettings('Info Bar') then
                        imgui.OpenPopup('Info Bar')
                    end
                    if imgui.BeginPopupModal('Info Bar', _, imgui.WindowFlags.NoResize) then
                        if imguitable.cpopupblur[0] then mimgui_blur.apply(imgui.GetBackgroundDrawList(), imguitable.blurradius[0]) end
                        imgui.SetWindowSizeVec2(imgui.ImVec2(350, -1))
                        textbg()
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                        imgui.CenterText(('Настройки'))
                        imgui.Separator()
                        if imgui.Button('Изменить положение',imgui.ImVec2(-1,30)) then
                            changeinfobarpos = true
                            imguitable.renderWindow.switch()
                            imgui.CloseCurrentPopup()
                            msg('Для того, что бы сохранить положение нажмите ЛКМ')
                        end
                        imgui.BeginChild('##infofarpopup', imgui.ImVec2(-1,230), true)
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Nick_Name'), imguitable.cinfoBarNick) then
                            ini.main.infoBarNick = imguitable.cinfoBarNick[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('ID'), imguitable.cinfoBarId) then
                            ini.main.infoBarId = imguitable.cinfoBarId[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Health'), imguitable.cinfoBarHp) then
                            ini.main.infoBarHp = imguitable.cinfoBarHp[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Armour'), imguitable.cinfoBarAp) then
                            ini.main.infoBarAp = imguitable.cinfoBarAp[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Lvl'), imguitable.cinfoBarLvl) then
                            ini.main.infoBarLvl = imguitable.cinfoBarLvl[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Ping'), imguitable.cinfoBarPing) then
                            ini.main.infoBarPing = imguitable.cinfoBarPing[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Skin'), imguitable.cinfoBarSkin) then
                            ini.main.infoBarSkin = imguitable.cinfoBarSkin[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        if imgui.SelectItem(('Date'), imguitable.cinfoBarTime) then
                            ini.main.infoBarTime = imguitable.cinfoBarTime[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.EndChild()
                        if imgui.Button('Закрыть', imgui.ImVec2(-1, 30)) then
                            imgui.CloseCurrentPopup()
                        end
                        imgui.End()
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    imgui.CustomCheckbox('Auto Piar', imguitable.cautopiar)
                    imgui.SameLine()
                    if imgui.ItemSettings('Auto Piar') then
                        imgui.OpenPopup('Auto Piar')
                    end
                    if imgui.BeginPopupModal('Auto Piar', _, imgui.WindowFlags.NoResize) then
                        if imguitable.cpopupblur[0] then mimgui_blur.apply(imgui.GetBackgroundDrawList(), imguitable.blurradius[0]) end
                        imgui.SetWindowSizeVec2(imgui.ImVec2(450, -1))
                        textbg()
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                        imgui.CenterText(('Настройки'))
                        imgui.Separator()
                        imgui.BeginChild('##autopiarpopup', imgui.ImVec2(-1,280),true)
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##chat', imguitable.cpiarchat) then
                            ini.autopiar.chat = imguitable.cpiarchat[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##chatinput', 'Чат', imguitable.epiarchat, ffi.sizeof(imguitable.epiarchat)) then
                            ini.autopiar.echat = ffi.string(imguitable.epiarchat)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##wpiarchat',imguitable.wpiarchat,100) then
                            ini.autopiar.chatwait = imguitable.wpiarchat[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##s', imguitable.cpiars) then
                            ini.autopiar.s = imguitable.cpiars[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##sinput', 'Крик', imguitable.epiars, ffi.sizeof(imguitable.epiars)) then
                            ini.autopiar.es = ffi.string(imguitable.epiars)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##wpiars',imguitable.wpiars,100) then
                            ini.autopiar.swait = imguitable.wpiars[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##c', imguitable.cpiarc) then
                            ini.autopiar.c = imguitable.cpiarc[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##cinput', 'Шепот', imguitable.epiarc, ffi.sizeof(imguitable.epiarc)) then
                            ini.autopiar.ec = ffi.string(imguitable.epiarc)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##cpiars',imguitable.wpiarc,100) then
                            ini.autopiar.cwait = imguitable.wpiarc[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##vr', imguitable.cpiarvr) then
                            ini.autopiar.vr = imguitable.cpiarvr[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##vrinput', 'Вип чат', imguitable.epiarvr, ffi.sizeof(imguitable.epiarvr)) then
                            ini.autopiar.evr = ffi.string(imguitable.epiarvr)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##vrpiars',imguitable.wpiarvr,100) then
                            ini.autopiar.vrwait = imguitable.wpiarvr[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##rb', imguitable.cpiarrb) then
                            ini.autopiar.rb = imguitable.cpiarrb[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##rbinput', 'Чат организации', imguitable.epiarrb, ffi.sizeof(imguitable.epiarrb)) then
                            ini.autopiar.erb = ffi.string(imguitable.epiarrb)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##rbpiars',imguitable.wpiarrb,100) then
                            ini.autopiar.rbwait = imguitable.wpiarrb[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##fb', imguitable.cpiarfb) then
                            ini.autopiar.fb = imguitable.cpiarfb[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##fbinput', 'Чат банды', imguitable.epiarfb, ffi.sizeof(imguitable.epiarfb)) then
                            ini.autopiar.efb = ffi.string(imguitable.epiarfb)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##fbpiars',imguitable.wpiarfb,100) then
                            ini.autopiar.fbwait = imguitable.wpiarfb[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##fam', imguitable.cpiarfam) then
                            ini.autopiar.fam = imguitable.cpiarfam[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##faminput', 'Чат семьи', imguitable.epiarfam, ffi.sizeof(imguitable.epiarfam)) then
                            ini.autopiar.efam = ffi.string(imguitable.epiarfam)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##wpiarfam',imguitable.wpiarfam,100) then
                            ini.autopiar.famwait = imguitable.wpiarfam[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SetCursorPosX(10)
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                        if imgui.CustomCheckbox('##ad', imguitable.cpiarad) then
                            ini.autopiar.ad = imguitable.cpiarad[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(255)
                        if imgui.InputTextWithHint('##adinput', 'СМИ (/ad)', imguitable.epiarad, ffi.sizeof(imguitable.epiarad)) then
                            ini.autopiar.ead = ffi.string(imguitable.epiarad)
                            inicfg.save(ini, directIni)
                        end
                        imgui.SameLine()
                        imgui.PushItemWidth(130)
                        if imgui.InputInt('##wpiarad',imguitable.wpiarad,100) then
                            ini.autopiar.adwait = imguitable.wpiarad[0]
                            inicfg.save(ini, directIni)
                        end
                        imgui.EndChild()
                        if imgui.Button('Закрыть', imgui.ImVec2(-1, 30)) then
                            imgui.CloseCurrentPopup()
                        end
                        imgui.End()
                    end
                    imgui.EndChild()
                elseif tabs.maintab == 5 then --УВЕДОМЛЕНИЯ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Уведомления')
                    imgui.Separator()
                    imgui.BeginChild('##notify',imgui.ImVec2(200,-1), true)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Уведомления', imguitable.cnotify) then
                        ini.main.notify = imguitable.cnotify[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.SelectItem('Telegram', imguitable.ctgnotify) then
                        ini.main.notifyTelegram = imguitable.ctgnotify[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    if imgui.ItemSettings('Telegram Notify Settings') then
                        tabs.notifytab = 1
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.SelectItem('VK', imguitable.cvknotify) then
                        ini.main.notifyVk = imguitable.cvknotify[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SameLine()
                    if imgui.ItemSettings('VK Notify Settings') then
                        tabs.notifytab = 2
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    imgui.SelectItem('Viber', imguitable.cvibernotify)
                    imgui.Hint('roflnotify', ('Рофл, с только телегой и вк выглядит скудно как-то'))
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    imgui.SelectItem('WhatsApp', imguitable.cwhatsappnotify)
                    imgui.Hint('roflnotify1', ('Рофл, с только телегой и вк выглядит скудно как-то'))
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    imgui.SelectItem('Skype', imguitable.cskypenotify)
                    imgui.Hint('roflnotify2', ('Рофл, с только телегой и вк выглядит скудно как-то'))
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    imgui.SelectItem('Голубиная почта', imguitable.cgolubinayapochtanotify)
                    imgui.Hint('roflnotify3', ('Рофл, с только телегой и вк выглядит скудно как-то'))
                    imgui.EndChild()
                    imgui.SameLine()
                    imgui.BeginChild('##notifysettings',imgui.ImVec2(-1,-1), true, imgui.WindowFlags.NoScrollbar)
                    if tabs.notifytab == 1 then
                        textbg()
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                        imgui.CenterText('Telegram')
                        imgui.Separator()
                        imgui.PushItemWidth(-1)
                        if imgui.InputTextWithHint('##tgbottoken', ('Укажите token бота'), imguitable.tgbottoken, ffi.sizeof(imguitable.tgbottoken), imgui.InputTextFlags.Password) then
                            ini.main.tgbottoken = ffi.string(imguitable.tgbottoken)
                            inicfg.save(ini, directIni)
                        end
                        if imgui.InputTextWithHint('##tgidchat', ('Укажите Ваш chat id'), imguitable.tgchatid, ffi.sizeof(imguitable.tgchatid)) then
                            ini.main.tgbotchatid = ffi.string(imguitable.tgchatid)
                            inicfg.save(ini, directIni)
                        end
                        if bot == nil then
                            if imgui.Button('Подключиться', imgui.ImVec2(-1,35)) then
                                bot = Telegram(ini.main.tgbottoken)
                                bot:connect()
                                bot:on('ready', function(data)
                                    msg('[Telegram Notifications] Бот успешно запустился! Имя: '..data.first_name)
                                end)
                            end
                        end
                        if imgui.Button(('Тестовое сообщение'), imgui.ImVec2(-1,25)) then
                            sendTelegramMsg('Привет, это тестовое сообщение! Все работает!')
                        end
                        imgui.CenterText('Выберите событие,')
                        imgui.CenterText('при котором будет приходить уведомление')

                        if imgui.CustomCheckbox('Краш скрипта', imguitable.tgscriptcrash) then
                            ini.tgnotify.scriptcrash = imguitable.tgscriptcrash[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Установка позиции', imguitable.tgsetpos) then
                            ini.tgnotify.setpos = imguitable.tgsetpos[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Установка HP', imguitable.tgsethp) then
                            ini.tgnotify.sethp = imguitable.tgsethp[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Установка AP', imguitable.tgsetap) then
                            ini.tgnotify.setap = imguitable.tgsetap[0]
                            inicfg.save(ini, directIni)
                        end

                        if imgui.CustomCheckbox('Выдача денег', imguitable.tggivemoney) then
                            ini.tgnotify.givemoney = imguitable.tggivemoney[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Удаление оружия', imguitable.tgremoveweapon) then
                            ini.tgnotify.removeweapon = imguitable.tgremoveweapon[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Заморозка/Разморозка', imguitable.tgplayercontrol) then
                            ini.tgnotify.playercontrol = imguitable.tgplayercontrol[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Изменение скина', imguitable.tgchangeskin) then
                            ini.tgnotify.changeskin = imguitable.tgchangeskin[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Смерть', imguitable.tgplayerdied) then
                            ini.tgnotify.playerdied = imguitable.tgplayerdied[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Спавн', imguitable.tgplayerspawn) then
                            ini.tgnotify.playerspawn = imguitable.tgplayerspawn[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Кик', imguitable.tgdisconnect) then
                            ini.tgnotify.disconnect = imguitable.tgdisconnect[0]
                            inicfg.save(ini, directIni)
                        end
                        if imgui.CustomCheckbox('Потерянно соединение', imguitable.tglostconnection) then
                            ini.tgnotify.lostconnection = imguitable.tglostconnection[0]
                            inicfg.save(ini, directIni)
                        end
                    elseif tabs.notifytab == 2 then
                        textbg()
                        imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                        imgui.CenterText('VK')
                        imgui.Separator()
                        imgui.CenterText('Soon')
                    end
                    imgui.EndChild()
                elseif tabs.maintab == 6 then --КАСТОМИЗАЦИЯ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Кастомизация')
                    imgui.Separator()
                    imgui.BeginChild('##CusLeft', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Изменение цветов окна TAB', imguitable.ctab) then
                        ini.main.changetab = imguitable.ctab[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('tabcolor', 'Цвета TAB будут изменяться')
                    imgui.SetCursorPosX(10)
                    if imgui.ColorEdit4('##Color1', ctabone, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then ini.main.firsttabcolor = imgui.ColorConvertFloat4ToU32(imgui.ImVec4( ctabone[0], ctabone[1], ctabone[2], ctabone[3] )) inicfg.save(ini, directIni) end
                    imgui.SameLine()
                    if imgui.ColorEdit4('##Color2', ctabtwo, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then ini.main.twotabcolor = imgui.ColorConvertFloat4ToU32(imgui.ImVec4( ctabtwo[0], ctabtwo[1], ctabtwo[2], ctabtwo[3] )) inicfg.save(ini, directIni) end
                    imgui.SameLine()
                    if imgui.ColorEdit4('##Color3', ctabthree, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then ini.main.threetabcolor = imgui.ColorConvertFloat4ToU32(imgui.ImVec4( ctabthree[0], ctabthree[1], ctabthree[2], ctabthree[3] )) inicfg.save(ini, directIni) end
                    imgui.SameLine()
                    if imgui.ColorEdit4('##Color4', ctabfour, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then ini.main.fourtabcolor = imgui.ColorConvertFloat4ToU32(imgui.ImVec4( ctabfour[0], ctabfour[1], ctabfour[2], ctabfour[3] )) inicfg.save(ini, directIni) end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Изменение стиля диалога', imguitable.cdialog) then
                        if imguitable.cdialog[0] then
                            dialogstyle(imguitable.ditype[0])
                        else
                            dialogstyle(2)
                        end
                        ini.main.changedialog = imguitable.cdialog[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('dialogstyle', 'Изменение внешнего вида обычных далогов\n0 - дефолт с блюром\n2 - без блюра (повышает фпс при открытом диалоге)')
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    imgui.PushItemWidth(-1)
                    if imgui.SliderInt('##dialog',imguitable.ditype,0,2) then
                        if imguitable.cdialog[0] then
                            dialogstyle(imguitable.ditype[0])
                        end
                        ini.main.dialogtype = imguitable.ditype[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Изменение FOV', imguitable.cfov) then
                        if imguitable.cfov[0] then
                            cameraSetLerpFov(imguitable.fov[0], imguitable.fov[0], 1000, 1)
                        else
                            cameraSetLerpFov(70, 70, 1000, 1)
                        end
                        ini.main.changefov = imguitable.cfov[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.SliderInt('##fov',imguitable.fov,1,120) then
                        ini.main.fov = imguitable.fov[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Динамический FOV', imguitable.cdynamicfov) then
                        ini.main.dynamicfov = imguitable.cdynamicfov[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Hint('##dynaimcfov', 'Динамический FOV как в GTA 4\nНе работает с вкл изненением FOV')
                    imgui.EndChild()

                    imgui.SameLine()

                    imgui.BeginChild('##CusRight', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Блокировка смены времени', imguitable.ctime) then
                        ini.main.blocktime = imguitable.ctime[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Блокировка смены погоды', imguitable.cweather) then
                        ini.main.blockweather = imguitable.cweather[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.Separator()
                    imgui.CenterText('Установка погоды и времени')
                    imgui.PushItemWidth(imgui.GetWindowSize().x-10)
                    if imgui.SliderInt('##time',imguitable.stime,0,23) then
                        setWorldTime(imguitable.stime[0])
                        ini.main.time = imguitable.stime[0]
                        inicfg.save(ini, directIni)
                    end
                    if imgui.SliderInt('##weather',imguitable.sweather,0,45) then
                        setWorldWeather(imguitable.sweather[0])
                        ini.main.weather = imguitable.sweather[0]
                        inicfg.save(ini, directIni)
                    end
                    imgui.EndChild()
                elseif tabs.maintab == 7 then -- НАСТРОЙКИ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Настройки')
                    imgui.Separator()
                    imgui.BeginChild('##SLeft', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    local keymenu = hotkey.KeyEditor('menu', 'Открытие меню', imgui.ImVec2(-1, 24))
                    if keymenu then
                        ini.bind.menu = encodeJson(keymenu)
                        inicfg.save(ini, directIni)
                    end
                    imgui.EndChild()
                    imgui.SameLine()
                    imgui.BeginChild('##SRight', imgui.ImVec2(235, -1), true, imgui.WindowFlags.NoScrollbar)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+5)
                    if imgui.CustomCheckbox('Размытие фона в настройках', imguitable.cpopupblur) then
                        ini.main.popupblur = imguitable.cpopupblur[0]
                        inicfg.save(ini, directIni)
                    end
                    if imguitable.cpopupblur[0] then
                        imgui.PushItemWidth(-1)
                        imgui.Text('Радиус размытия')
                        if imgui.SliderInt('##Радиус размытия', imguitable.blurradius, 1, 50) then
                            ini.main.blurradius = imguitable.blurradius[0]
                            inicfg.save(ini, directIni)
                        end
                    end
                    imgui.EndChild()
                elseif tabs.maintab == 8 then -- ИНФОРМАЦИЯ
                    imgui.SetCursorPosY(imgui.GetCursorPosY()+2)
                    imgui.CenterText('Информация')
                    imgui.Separator()
                    imgui.BeginChild('##info', imgui.ImVec2(-1,-1), true)
                    imgui.SetCursorPosX(10)
                    imgui.SetCursorPosY(10)
                    imgui.TextWrapped('Rodina Helper - это новый и уникальный в своем роде помощник для проекта Rodina RP.\nСкрипт имеет функций, и подойдет всем категориям игроков.\nСкрипт не выступает в роле чита, он направлен на помощь и облегчение игрового процесса.')
                    imgui.SetCursorPosY(200)
                    imgui.SetCursorPosX(10)
                    imgui.Text('Автор:')
                    imgui.SameLine()
                    imgui.Link('https://www.blast.hk/members/413482/', 'Willy4ka')
                    imgui.SetCursorPosX(10)
                    imgui.Text('Нашли баг?')
                    imgui.SameLine()
                    imgui.Link('https://www.blast.hk/members/413482/', 'Напишите о нем в тему!')
                    imgui.SetCursorPosX(10)
                    imgui.Text('Поддержать разработку:')
                    imgui.SameLine()
                    imgui.Link('https://www.donationalerts.com/r/willy4ka', 'DonationAlerts')
                    imgui.EndChild()
                end
            imgui.EndChild()
            imgui.End()
            imgui.PopStyleVar()
        end
    end
)
imgui.OnFrame(
    function() return imguitable.calcWindow[0] end,
    function(self)
        self.HideCursor = true
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, 1.00)
        local input = sampGetInputInfoPtr()
        input = getStructElement(input, 0x8, 4)
        local windowPosX = getStructElement(input, 0x8, 4)
        local windowPosY = getStructElement(input, 0xC, 4)
        if sampIsChatInputActive() and ok then
            imgui.SetNextWindowPos(imgui.ImVec2(windowPosX, windowPosY + 30 + 15), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowSize(imgui.ImVec2(chatcalcresult:len()*10, 30))
            imgui.Begin('##calc', _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
            imgui.SetCursorPosY((imgui.GetWindowSize().y-imgui.CalcTextSize(chatcalcresult).y)/2)
            imgui.CenterText((number_separator(chatcalcresult)))
            imgui.End()
            imgui.PopStyleVar()
        end
    end
)
imgui.OnFrame(
    function() return imguitable.infoBarWindow.alpha>0.00 end,
    function(self)
        self.HideCursor = not changeinfobarpos
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, imguitable.infoBarWindow.alpha)
        local sizeX, sizeY = 220, -1
        imgui.SetNextWindowPos(imgui.ImVec2(ini.main.infoBarPosX, ini.main.infoBarPosY))
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        if imgui.Begin('##InfoBar', _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar) then
            local result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            if result then
                local nick = u8(sampGetPlayerNickname(id))
                local hp = sampGetPlayerHealth(id)
                local ap = sampGetPlayerArmor(id)
                local ping = sampGetPlayerPing(id)
                local lvl = sampGetPlayerScore(id)
                local skin = getCharModel(PLAYER_PED)
                local date = os.date('%d')..'.'..os.date('%m')..'.'..os.date('%y')..' | '..os.date('%A')..' | '..os.date('%H')..':'..os.date('%M')..':'..os.date('%S')
                imgui.CenterText('Info Bar')
                imgui.Separator()
                local idd = imguitable.cinfoBarId[0] and ' ['..id..']' or ''
                if imguitable.cinfoBarNick[0] then imgui.TextWrapped((nick..idd)) end
                if not imguitable.cinfoBarNick[0] and imguitable.cinfoBarId[0] then imgui.TextWrapped((id..' ID')) end
                if imguitable.cinfoBarHp[0] then imgui.TextWrapped((hp..' HP')) end
                if imguitable.cinfoBarAp[0] then imgui.TextWrapped((ap..' AP')) end
                if imguitable.cinfoBarLvl[0] then imgui.TextWrapped((lvl..' LVL')) end
                if imguitable.cinfoBarPing[0] then imgui.TextWrapped((ping..'ms PING')) end
                if imguitable.cinfoBarSkin[0] then imgui.TextWrapped((skin..' SKIN id')) end
                if imguitable.cinfoBarTime[0] then imgui.TextWrapped((date)) end
            end
            imgui.End()
            imgui.PopStyleVar()
        end
    end
)
imgui.OnFrame(
    function() return imguitable.updateWindow.alpha>0.00 end,
    function(self)
        self.HideCursor = imguitable.renderWindow.state
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, imguitable.updateWindow.alpha)
        local sizeX, sizeY = 400, 400
        local resX, resY = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        if imgui.Begin('##Update', _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar) then
            imgui.CenterText('RodinaHelper')
            imgui.Separator()
            imgui.BeginChild('##upd', imgui.ImVec2(-1,-1), true)
            imgui.PushFont(arialtext)
            imgui.CenterText('Доступно обновление!')
            imgui.PopFont()
            if updates.ver ~= nil and updates.date ~= nil and updates.changes ~= nil then
                imgui.Text('Дата: '..updates.date)
                imgui.Text('Версия: '..updates.ver)
                imgui.Text('Изменения:')
                imgui.BeginChild('##updatelist', imgui.ImVec2(-1, 230), true, imgui.WindowFlags.NoScrollbar)
                imgui.Text(updates.changes)
                imgui.EndChild()
                imgui.SetCursorPosY(imgui.GetWindowSize().y-40)
                if imgui.Button('Установить', imgui.ImVec2(187,35)) then
                    downloadUpdate()
                end
                imgui.SameLine()
                if imgui.Button('Пропустить', imgui.ImVec2(187,35)) then
                    imguitable.updateWindow.fl()
                end
            end
            imgui.EndChild()
            imgui.End()
            imgui.PopStyleVar()
        end
    end
)

addEventHandler('onWindowMessage', function(msg, wparam, lparam)
    if wparam == 27 then
        if imguitable.renderWindow.state then
            if msg == wm.WM_KEYDOWN then
                consumeWindowMessage(true, false)
            end
            if msg == wm.WM_KEYUP then
                imguitable.renderWindow.switch()
            end
        end
    end
    if changeinfobarpos then
        if msg == wm.WM_LBUTTONDOWN then
            consumeWindowMessage(true, false)
        end
        if msg == wm.WM_LBUTTONUP then
            changeinfobarpos = false
            inicfg.save(ini, directIni)
        end
    end
    if msg == wm.WM_RBUTTONDOWN then
        hidemenu = true
    elseif msg == wm.WM_RBUTTONUP then
        hidemenu = false
    end
end)
function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end
function imgui.DarkTheme()
    imgui.SwitchContext()
    --==[ STYLE ]==--
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 10

    --==[ BORDER ]==--
    imgui.GetStyle().WindowBorderSize = 1
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1

    --==[ ROUNDING ]==--
    imgui.GetStyle().WindowRounding = 5
    imgui.GetStyle().ChildRounding = 5
    imgui.GetStyle().FrameRounding = 5
    imgui.GetStyle().PopupRounding = 5
    imgui.GetStyle().ScrollbarRounding = 5
    imgui.GetStyle().GrabRounding = 5
    imgui.GetStyle().TabRounding = 5

    --==[ ALIGN ]==--
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    
    --==[ COLORS ]==--
    imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.50)
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
end
function imgui.CustomCheckbox(str_id, bool, a_speed)
    local p         = imgui.GetCursorScreenPos()
    local DL        = imgui.GetWindowDrawList()

    local label     = str_id:gsub('##.+', '') or ""
    local h         = imgui.GetTextLineHeightWithSpacing() + 2
    local speed     = a_speed or 0.1

    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec2(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end
    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end

    local c = {
        {0.18536826495, 0.42833250947},
        {0.44109925858, 0.70010380622},
        {0.38825341901, 0.70010380622},
        {0.81248970176, 0.28238693976},
    }

    if UI_CUSTOM_CHECKBOX == nil then UI_CUSTOM_CHECKBOX = {} end
    if UI_CUSTOM_CHECKBOX[str_id] == nil then
        UI_CUSTOM_CHECKBOX[str_id] = {
            lines = {
                {
                    from = imgui.ImVec2(0, 0),
                    to = imgui.ImVec2(h*c[1][1], h*c[1][2]),
                    start = 0,
                    anim = false,
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = bool[0] and imgui.ImVec2(h*c[2][1], h*c[2][2]) or imgui.ImVec2(h*c[1][1], h*c[1][2]),
                    start = 0,
                    anim = false,
                },
                {
                    from = imgui.ImVec2(0, 0),
                    to = imgui.ImVec2(h*c[3][1], h*c[3][2]),
                    start = 0,
                    anim = false,
                },
                {     
                    from = imgui.ImVec2(0, 0),   
                    to = bool[0] and imgui.ImVec2(h*c[4][1], h*c[4][2]) or imgui.ImVec2(h*c[3][1], h*c[3][2]),
                    start = 0,
                    anim = false,
                },
            },
            hovered = false,
            h_start = 0,
        }
    end

    local pool = UI_CUSTOM_CHECKBOX[str_id]

    imgui.BeginGroup()
        imgui.InvisibleButton(str_id, imgui.ImVec2(h, h))
        imgui.SameLine()
        local pp = imgui.GetCursorPos()
        imgui.SetCursorPos(imgui.ImVec2(pp.x, pp.y + h/2 - imgui.CalcTextSize(label).y/2))
        imgui.Text(label)
    imgui.EndGroup()

    local clicked = imgui.IsItemClicked()
    if pool.hovered ~= imgui.IsItemHovered() then
        pool.hovered = imgui.IsItemHovered()
        local timer = os.clock() - pool.h_start
        if timer <= speed and timer >= 0 then
            pool.h_start = os.clock() - (speed - timer)
        else
            pool.h_start = os.clock()
        end
    end

    if clicked then
        local isAnim = false

        for i = 1, 4 do
            if pool.lines[i].anim then
                isAnim = true
            end
        end

        if not isAnim then
            bool[0] = not bool[0]

            pool.lines[1].from = imgui.ImVec2(h*c[1][1], h*c[1][2])
            pool.lines[1].to = bool[0] and imgui.ImVec2(h*c[1][1], h*c[1][2]) or imgui.ImVec2(h*c[2][1], h*c[2][2])
            pool.lines[1].start = bool[0] and 0 or os.clock()

            pool.lines[2].from = bool[0] and imgui.ImVec2(h*c[1][1], h*c[1][2]) or imgui.ImVec2(h*c[2][1], h*c[2][2])
            pool.lines[2].to = bool[0] and imgui.ImVec2(h*c[2][1], h*c[2][2]) or imgui.ImVec2(h*c[2][1], h*c[2][2])
            pool.lines[2].start = bool[0] and os.clock() or 0

            pool.lines[3].from = imgui.ImVec2(h*c[3][1], h*c[3][2])
            pool.lines[3].to = bool[0] and imgui.ImVec2(h*c[3][1], h*c[3][2]) or imgui.ImVec2(h*c[4][1], h*c[4][2])
            pool.lines[3].start = bool[0] and 0 or os.clock() + speed

            pool.lines[4].from = bool[0] and imgui.ImVec2(h*c[3][1], h*c[3][2]) or imgui.ImVec2(h*c[4][1], h*c[4][2])
            pool.lines[4].to = imgui.ImVec2(h*c[4][1], h*c[4][2]) or imgui.ImVec2(h*c[4][1], h*c[4][2])
            pool.lines[4].start = bool[0] and os.clock() + speed or 0
        end
    end

    local pos = {}

    for i = 1, 4 do
        pos[i], pool.lines[i].anim = bringVec2To(
            p + pool.lines[i].from,
            p + pool.lines[i].to,
            pool.lines[i].start,
            speed
        )
    end

    local color = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
    local c = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
    local colorHovered = bringVec4To(
        pool.hovered and imgui.ImVec4(c.x, c.y, c.z, 0) or imgui.ImVec4(c.x, c.y, c.z, 0.2),
        pool.hovered and imgui.ImVec4(c.x, c.y, c.z, 0.2) or imgui.ImVec4(c.x, c.y, c.z, 0),
        pool.h_start,
        speed
    )

    DL:AddRectFilled(p, imgui.ImVec2(p.x + h, p.y + h), imgui.GetColorU32Vec4(colorHovered), h/15, 15)
    DL:AddRect(p, imgui.ImVec2(p.x + h, p.y + h), imgui.GetColorU32Vec4(color), h/15, 15, 1.5)
    DL:AddLine(pos[1], pos[2], imgui.GetColorU32Vec4(color), h/10)
    DL:AddLine(pos[3], pos[4], imgui.GetColorU32Vec4(color), h/10)
    
    return clicked
end
function imgui.SelectItem(str_id, bool, size, speed)
    local p         = imgui.GetCursorScreenPos()
    local DL        = imgui.GetWindowDrawList()

    local label     = str_id:gsub('##.+', '') or ""
    local h         = imgui.GetTextLineHeightWithSpacing() + 2
    speed           = speed or 0.1
    size            = size or 10
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return (from + (count * (to - from) / 100)), true
        end
        return (timer > duration) and to or from, false
    end
    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end
    if UI_SelectItem == nil then UI_SelectItem = {} end
    if UI_SelectItem[str_id] == nil then
        UI_SelectItem[str_id] = {
            from = bool[0] and 0 or size-2,
            to = bool[0] and size-2 or 0,
            start = 0,
            anim = false,
            hovered = false,
            h_start = 0,
        }
    end

    local pool = UI_SelectItem[str_id]

    imgui.BeginGroup()
        imgui.InvisibleButton(str_id, imgui.ImVec2(size*2, size*2))
        local pp = imgui.GetCursorPos()
        imgui.SameLine(pp.x+(size*2))
        pp = imgui.GetCursorPos()
        imgui.SetCursorPos(imgui.ImVec2(pp.x, (pp.y + h/2 - imgui.CalcTextSize(label).y/2)))
        imgui.TextWrapped(label)
    imgui.EndGroup()

    local clicked = imgui.IsItemClicked()
    if pool.hovered ~= imgui.IsItemHovered() then
        pool.hovered = imgui.IsItemHovered()
        local timer = os.clock() - pool.h_start
        if timer <= speed and timer >= 0 then
            pool.h_start = os.clock() - (speed - timer)
        else
            pool.h_start = os.clock()
        end
    end

    if clicked then
        local isAnim = false

        if pool.anim then
            isAnim = true
        end

        if not isAnim then
            bool[0] = not bool[0]
            pool.from = bool[0] and 0 or size-2
            pool.to = bool[0] and size-2 or 0
            pool.start = os.clock()
        end
    end

    local rad = 0
    rad,pool.anim = bringVec2To(
        pool.from,
        pool.to,
        pool.start,
        speed
    )

    local bordercolor = imgui.GetStyle().Colors[imgui.Col.Border]
    local c = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
    local colorHovered = bringVec4To(
        pool.hovered and imgui.ImVec4(c.x, c.y, c.z, 0) or imgui.ImVec4(c.x, c.y, c.z, 0.2),
        pool.hovered and imgui.ImVec4(c.x, c.y, c.z, 0.2) or imgui.ImVec4(c.x, c.y, c.z, 0),
        pool.h_start,
        speed
    )

    DL:AddCircleFilled(imgui.ImVec2(p.x + size, p.y + size), size, 0x80303030, 25)
    DL:AddCircle(imgui.ImVec2(p.x + size, p.y + size), size+3, imgui.GetColorU32Vec4(bordercolor),25)
    DL:AddCircleFilled(imgui.ImVec2(p.x + size, p.y + size), size, imgui.GetColorU32Vec4(colorHovered), 25)
    DL:AddCircleFilled(imgui.ImVec2(p.x + size, p.y + size), rad, 0x80808080, 25)
    return clicked
end
function imgui.GradientPB(bool, icon, text, duration, size)
    -- \\ Variables
    local GradientPB = {}
    icon = icon or '#'
    text = text or 'None'
    size = size or imgui.ImVec2(190, 35)
    duration = duration or 0.50
    
    local black = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 1.00))
    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    
    if not GradientPB[text] then
        GradientPB[text] = {time = nil}
    end
    
    -- \\ Button
    local result = imgui.InvisibleButton(text, size)
    if result and not bool then
        GradientPB[text].time = os.clock()
    end

    -- \\ Gradient to button + Animation
    if bool then
        dl:AddRectFilledMultiColor(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), 0x10FFFFFF, black, black, 0x10FFFFFF)
    else
        if imgui.IsItemHovered() then
            dl:AddRectFilledMultiColor(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), 0x10AAAAAA, black, black, 0x10AAAAAA)
        end
    end
    
    -- \\ Text
    imgui.SameLine(10); imgui.SetCursorPosY(imgui.GetCursorPos().y + 9)
    if bool then
        imgui.Text((' '):rep(3) .. icon)
        imgui.SameLine(60)
        imgui.Text(text)
    else
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), (' '):rep(3) .. icon)
        imgui.SameLine(60)
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), text)
    end
    
    -- \\ Normal display
    imgui.SetCursorPosY(imgui.GetCursorPos().y - 9)
    
    -- \\ Result button
    return result
end
function imgui.ItemSettings(str_id)
    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local col = { 0xFF606060, 0xFF808080 }
    local btn = imgui.InvisibleButton(faicons('GEAR')..'##'..str_id, imgui.ImVec2(15,15))
    local color = imgui.IsItemHovered() and col[1] or col[2]
    dl:AddText(imgui.ImVec2(p.x,p.y+4), color, faicons('GEAR'))
    return btn
end
function imgui.ItemSelector(name, items, selected, fixedSize, dontDrawBorders)
    assert(items and #items > 1, 'items must be array of strings');
    assert(selected[0], 'Wrong argument #3. Selected must be "imgui.new.int"');
    local DL = imgui.GetWindowDrawList();
    local style = {
        rounding = imgui.GetStyle().FrameRounding,
        padding = imgui.GetStyle().FramePadding,
        col = {
            default = imgui.GetStyle().Colors[imgui.Col.Button],
            hovered = imgui.GetStyle().Colors[imgui.Col.ButtonHovered],
            active = imgui.GetStyle().Colors[imgui.Col.ButtonActive],
            text = imgui.GetStyle().Colors[imgui.Col.Text]
        }
    };
    local pos = imgui.GetCursorScreenPos();
    local start = pos;
    local maxSize = 0;
    for index, item in ipairs(items) do
        local textSize = imgui.CalcTextSize(item);
        local sizeX = (fixedSize or textSize.x) + style.padding.x * 2;
        imgui.SetCursorScreenPos(pos);
        if imgui.InvisibleButton('##imguiSelector_'..item..'_'..tostring(index), imgui.ImVec2(sizeX, textSize.y + style.padding.y * 2)) then
            local old = selected[0];
            selected[0] = index;
            return selected[0], old;
        end
        DL:AddRectFilled(
            pos,
            imgui.ImVec2(pos.x + sizeX, pos.y + textSize.y + style.padding.y * 2),
            imgui.GetColorU32Vec4((selected[0] == index or imgui.IsItemActive()) and style.col.active or (imgui.IsItemHovered() and style.col.hovered or style.col.default)),
            style.rounding,
            (index == 1 and 5 or (index == #items and 10 or 0))
        );
        if index > 1 and not dontDrawBorders then DL:AddLine(imgui.ImVec2(pos.x, pos.y + style.padding.y), imgui.ImVec2(pos.x, pos.y + textSize.y + style.padding.y), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Border]), 1) end
        DL:AddText(imgui.ImVec2(pos.x + sizeX / 2 - textSize.x / 2, pos.y + style.padding.y), imgui.GetColorU32Vec4(style.col.text), item);
        pos = imgui.ImVec2(pos.x + sizeX, pos.y);
    end
    DL:AddRect(start, imgui.ImVec2(pos.x, pos.y + imgui.CalcTextSize('A').y + style.padding.y * 2), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Border]), imgui.GetStyle().FrameRounding, nil, imgui.GetStyle().FrameBorderSize);
    DL:AddText(imgui.ImVec2(pos.x + style.padding.x, pos.y + (imgui.CalcTextSize(name).y + style.padding.y * 2) / 2 - imgui.CalcTextSize(name).y / 2), imgui.GetColorU32Vec4(style.col.text), name);
end
function imgui.CustomInput(name, hint, buffer, bufferSize, flags, width)
    local width = width or imgui.GetWindowSize().x / 2;
    local DL = imgui.GetWindowDrawList();
    local pos = imgui.GetCursorScreenPos();
    local nameSize = imgui.CalcTextSize(name);
    local padding = imgui.GetStyle().FramePadding;
    DL:AddRectFilled(
        pos,
        imgui.ImVec2(pos.x + padding.x * 2 + nameSize.x, pos.y + nameSize.y + padding.y * 2),
        imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]),
        imgui.GetStyle().FrameRounding, 1 + 4
    );
    DL:AddRectFilled(
        imgui.ImVec2(pos.x + padding.x * 2 + nameSize.x, pos.y),
        imgui.ImVec2(pos.x + padding.x * 2 + nameSize.x + width, pos.y + nameSize.y + padding.y * 2),
        imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.FrameBg]),
        imgui.GetStyle().FrameRounding,
        10
    );
    DL:AddText(imgui.ImVec2(pos.x + padding.x, pos.y + padding.y), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Text]), name);
    imgui.SetCursorScreenPos(imgui.ImVec2(pos.x + padding.x * 2 + nameSize.x, pos.y))
    imgui.PushItemWidth(width);
    imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0, 0, 0, 0));
    local input = imgui.InputTextWithHint('##customInput_'..tostring(name), hint or '', buffer, bufferSize, flags);
    imgui.PopStyleColor();
    imgui.PopItemWidth();
    
    return input;
end
function imgui.Hint(str_id, hint_text, color)
    color = color or imgui.GetStyle().Colors[imgui.Col.PopupBg];
    local p_orig = imgui.GetCursorPos();
    local hovered = imgui.IsItemHovered();
    imgui.SameLine(nil, 0);
    local animTime = 0.2;
    local show = true;
    if not POOL_HINTS then POOL_HINTS = {} end;
    if not POOL_HINTS[str_id] then
        POOL_HINTS[str_id] = { status = false,timer = 0};
    end
    if hovered then
        for k, v in pairs(POOL_HINTS) do;
            if k ~= str_id and os.clock() - v.timer <= animTime  then;
                show = false;
            end;
        end;
    end;
    if show and POOL_HINTS[str_id].status ~= hovered then;
        POOL_HINTS[str_id].status = hovered;
        POOL_HINTS[str_id].timer = os.clock();
    end;
    local getContrastColor = function(col);
        local luminance = 1 - (0.299 * col.x + 0.587 * col.y + 0.114 * col.z);
        return luminance < 0.5 and imgui.ImVec4(0, 0, 0, 1) or imgui.ImVec4(1, 1, 1, 1);
    end;
    local rend_window = function(alpha);
        local size = imgui.GetItemRectSize();
        local scrPos = imgui.GetCursorScreenPos();
        local DL = imgui.GetWindowDrawList();
        local center = imgui.ImVec2( scrPos.x - (size.x / 2), scrPos.y + (size.y / 2) - (alpha * 4) + 10 );
        local a = imgui.ImVec2( center.x - 7, center.y - size.y - 3 );
        local b = imgui.ImVec2( center.x + 7, center.y - size.y - 3);
        local c = imgui.ImVec2( center.x, center.y - size.y + 3 );
        local col = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(color.x, color.y, color.z, alpha));
        DL:AddTriangleFilled(a, b, c, col);
        imgui.SetNextWindowPos(imgui.ImVec2(center.x, center.y - size.y - 3), imgui.Cond.Always, imgui.ImVec2(0.5, 1.0));
        imgui.PushStyleColor(imgui.Col.PopupBg, color);
        imgui.PushStyleColor(imgui.Col.Text, getContrastColor(color));
        imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(8, 8));
        imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 6);
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, alpha);
        local max_width = function(text);
            local result = 0;
            for line in text:gmatch('[^\n]+') do;
                local len = imgui.CalcTextSize(line).x;
                if len > result then;
                    result = len;
                end;
            end;
            return result;
        end;
        local hint_width = max_width(hint_text) + (imgui.GetStyle().WindowPadding.x * 2);
        imgui.SetNextWindowSize(imgui.ImVec2(hint_width+15, -1), imgui.Cond.Always);
        imgui.Begin('##' .. str_id, _, imgui.WindowFlags.Tooltip + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar);
        for line in hint_text:gmatch('[^\n]+') do;
            imgui.CenterText(line);
        end;
        imgui.End();
        imgui.PopStyleVar(3);
        imgui.PopStyleColor(2);
    end;
    if show then;
        local between = os.clock() - POOL_HINTS[str_id].timer;
        if between <= animTime then;
            local s = function(f);
                return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f);
            end;
            local alpha = hovered and s(between / animTime) or s(1.00 - between / animTime);
            rend_window(alpha);
        elseif hovered then;
            rend_window(1.00);
        end;
    end;
    imgui.SetCursorPos(p_orig);
end
function imgui.Link(link, text)
    text = text or link
    local tSize = imgui.CalcTextSize(text)
    local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
    local col = { 0xFF606060, 0xFF808080 }
    if imgui.InvisibleButton("##" .. link, tSize) then os.execute("explorer " .. link) end
    local color = imgui.IsItemHovered() and col[1] or col[2]
    DL:AddText(p, color, text)
end
function setTabColor(lt, rt, lb, rb)
    local samp_module_base = sampGetBase()
    local tab_ptr = memory.getuint32(samp_module_base + 0x26E970, true)
    memory.setuint32(tab_ptr + 0x12A, rb, true)
    memory.setuint32(tab_ptr + 0x12E, lb, true)
    memory.setuint32(tab_ptr + 0x132, rt, true)
    memory.setuint32(tab_ptr + 0x136, lt, true)
end
function msg(...)
    sampAddChatMessage(u8d('[RodinaHelper] {FFFFFF}'..table.concat({...},'\n')), 0x505050)
end
function argb2abgr(argb)
    local abgr = bit.bor(
        bit.lshift(bit.band(bit.rshift(argb, 24), 0xFF), 24),
        bit.lshift(bit.band(argb, 0xFF), 16),
        bit.lshift(bit.band(bit.rshift(argb, 8), 0xFF), 8),
        bit.band(bit.rshift(argb, 16), 0xFF)
    )
    return abgr
end
function onScriptTerminate(s, q)
    if s == thisScript() then
        if imguitable.tgscriptcrash[0] then
            sendTelegramMsg('Скрипт был выгружен/перезагружен')
        end
        for k, v in pairs(binds) do
            for key, value in pairs(v) do
                ini.bind.k = encodeJson(v.key)
                inicfg.save(ini, directIni)
            end
        end
    end
end
function setWorldTime(hour)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, hour)
    raknetEmulRpcReceiveBitStream(94, bs)
    raknetDeleteBitStream(bs)
end
function setWorldWeather(id)
    local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, id)
    raknetEmulRpcReceiveBitStream(152, bs)
    raknetDeleteBitStream(bs)
end
function textbg()
    local dl = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local size = imgui.ImVec2(imgui.GetWindowSize().x, 20)
    local black = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.07, 0.07, 0.07, 1.00))
    dl:AddRectFilledMultiColor(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + size.x, p.y + size.y), 0x10888888, black, black, 0x10888888)
end
function dialogstyle(code)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 53)
    raknetBitStreamWriteInt32(bs, code)
    raknetBitStreamWriteInt32(bs, string.len(''))
    raknetBitStreamWriteString(bs, '')
    raknetEmulPacketReceiveBitStream(220, bs)
    raknetDeleteBitStream(bs)
end
function number_separator(n) 
	local left, num, right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1 '):reverse())..right
end
function SaveBind()
    local list = {}
    for k, v in pairs(cusbinds) do
        for key, value in pairs(v) do
            local tbltext = value.text:gsub('\n',';')
            table.insert(list,('{name = "%s", type = %d, key = %s, wait = %d, bindtext = "%s", bindcef = "%s"},'):format(value.name, value.sendtype, encodeJson(value.keys), value.wait, tbltext,value.sendcef))
        end
    end
    local file = io.open(getWorkingDirectory()..'\\RodinaHelper\\binds.txt', 'w')
    if file then
        file:write(table.concat(list, '\n'))
        file:close()
    end
    cusbinds = {}
    LoadBinds()
end
function LoadBinds()
    cusbinds = {}
    local pattern = '%{name = "(.+)", type = (%d+), key = (.+), wait = (%d+), bindtext = "(.*)", bindcef = "(.*)"%},'
    local file = getWorkingDirectory()..'\\RodinaHelper\\binds.txt'
    for line in io.lines(file) do
        if line ~= '' then
            if line:find(pattern) then
                local tablename, tabletype, tablekey, tablewait, tabletext, tablecef = line:match(pattern)
                table.insert(cusbinds, {
                    [tablename] = {
                        name = tablename,
                        keys = decodeJson(tablekey),
                        wait = tonumber(tablewait),
                        sendtype = tonumber(tabletype),
                        text = tabletext:gsub(';', '\n'),
                        sendcef = tablecef,
                        callback = function()
                            if not sampIsCursorActive() and not isCursorActive() then
                                lua_thread.create(function ()
                                    if tonumber(tabletype) == 1 then
                                        tabletext = tabletext:gsub(';', '\n')
                                        for l in tabletext:gmatch("[^\r\n]+") do
                                            sampSendChat(u8d(l))
                                            wait(tonumber(tablewait))
                                        end
                                    elseif tonumber(tabletype) == 2 then
                                        cef(tablecef)
                                    end
                                end)
                            end
                        end,
                    }
                })
            end
        end
    end
    if cusbinds ~= nil then
        for k, v in pairs(cusbinds) do
            for key, value in pairs(v) do
                hotkey.RegisterCallback(value.name, decodeJson(value.keys), value.callback)
            end
        end
    end
end
function getItemByName(text)
    if cusbinds ~= nil and #cusbinds > 0 then
        for k, v in pairs(cusbinds) do
            for key, value in pairs(v) do
                return text ~= tostring(key)
            end
        end
    else
        return true
    end
end
function sendTelegramMsg(text)
    return bot:sendMessage{chat_id = tonumber(ini.main.tgbotchatid), text = (text)}
end
function checkupdate()
    local download = require('moonloader').download_status
    local jsonfile = getWorkingDirectory()..'\\RodinaHelper\\update.json'
    local jsonurl = 'https://raw.githubusercontent.com/Willy4ka1337/RodinaHelper/main/version.json'
    downloadUrlToFile(jsonurl, jsonfile, function(id, status, p1, p2)
        if status == download.STATUSEX_ENDDOWNLOAD then
            local file = io.open(jsonfile, 'r')
            local jsn = file:read('*a')
            file:close()
            local result, json = pcall(decodeJson, jsn)
            if result then
                if json.version ~= thisScript().version then
                    updates.ver = json.version
                    updates.date = json.date
                    updates.changes = json.changelog
                    imguitable.updateWindow.tr()
                else
                    msg('У вас установленна актуальная версия!')
                end
            end
        end
    end)
end
function downloadUpdate()
    local download = require('moonloader').download_status
    local downloadpath = 'https://raw.githubusercontent.com/Willy4ka1337/RodinaHelper/main/RodinaHelper.lua'
    downloadUrlToFile(downloadpath, thisScript().path, function (id, status, p1, p2)
        if status == download.STATUSEX_ENDDOWNLOAD then
            msg('Обновление успешно загруженно!')
            thisScript():reload()
        end
    end)
end
function u8d(text)
   return encoding.UTF8:decode(text)
end
function dialogstyle(code)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 53)
    raknetBitStreamWriteInt32(bs, code)
    raknetBitStreamWriteInt32(bs, string.len(''))
    raknetBitStreamWriteString(bs, '')
    raknetEmulPacketReceiveBitStream(220, bs)
    raknetDeleteBitStream(bs)
end
function onReceivePacket(id, bs)
    if id == 220 then
        raknetBitStreamReadInt8(bs);
        if raknetBitStreamReadInt8(bs) == 17 then
            raknetBitStreamReadInt32(bs);
            local len, text = raknetBitStreamReadInt32(bs), '';
            if len > 0 then
                text = raknetBitStreamReadString(bs, len)
                if text:find('vue%.call%(`(.+)`,(.+)%);') then
                    local event, data = text:match('vue%.call%(`(.+)`,(.+)%);');
                    if event == 'progressBar/updateData' and imguitable.aclick[0] then
                        cef('@24, pressKey')
                    end
                elseif text:find('window%.executeEvent%(\'(.+)\', \'(.+)\'%);') then
                    local event, data = text:match('window%.executeEvent%(\'(.+)\', \'(.+)\'%);')
                    if event == 'event.setActiveView' then
                        local view = data:match('%[(.+)%]')
                        if view == '"Auth"' and imguitable.alogin[0] then
                            sendAuth(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))), (ffi.string(imguitable.pass)))
                        end
                    end
                end
            end
        end
    elseif id == 33 then
        if imguitable.tglostconnection[0] then
            sendTelegramMsg('Потерянно соединение с сервером!')
        end
    elseif id == 32 then
        if imguitable.tgdisconnect[0] then
            sendTelegramMsg('Сервер закрыл соединение.')
        end
    end
end
function cef(text)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 220)
    raknetBitStreamWriteInt8(bs, 18)
    raknetBitStreamWriteInt8(bs, string.len(text))
    raknetBitStreamWriteInt8(bs, 0)
    raknetBitStreamWriteInt8(bs, 0)
    raknetBitStreamWriteInt8(bs, 0)
    raknetBitStreamWriteString(bs, text)
    raknetBitStreamWriteInt8(bs, 0)
    raknetBitStreamWriteInt8(bs, 0)
    raknetBitStreamWriteInt8(bs, 0)
    raknetSendBitStreamEx(bs, 2, 9, 6)
    raknetDeleteBitStream(bs)
end
function sendAuth(nick, password)
    local str = string.format("authorization|%s|%s|1", nick, password)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, 220)
    raknetBitStreamWriteInt8(bs, 18)
    raknetBitStreamWriteInt32(bs, string.len(str))
    raknetBitStreamWriteString(bs, str)
    raknetBitStreamWriteInt32(bs, 1)
    raknetSendBitStreamEx(bs, 2, 9, 6)
end
function sampev.onSetPlayerPos(position)
    if imguitable.tgsetpos[0] then
        sendTelegramMsg('Сервер изменил позицию персонажа на '..position.x..', '..position.y..', '..position.z)
    end
end
function sampev.onSetPlayerHealth(health)
    if imguitable.tgsethp[0] then
        sendTelegramMsg('Сервер изменил HP персонажа на '..health)
    end
end
function sampev.onSetPlayerArmour(armour)
    if imguitable.tgsetap[0] then
        sendTelegramMsg('Сервер изменил AP персонажа на '..armour)
    end
end
function sampev.onGivePlayerMoney(money)
    if imguitable.tggivemoney[0] then
        sendTelegramMsg('Сервер выдал персонажу $'..money)
    end
end
function sampev.onResetPlayerWeapons()
    if imguitable.tgremoveweapon[0] then
        sendTelegramMsg('Сервер удалил оружие у персонажа!')
    end
end
function sampev.onTogglePlayerControllable(controllable)
    if imguitable.tgplayercontrol[0] then
        sendTelegramMsg('Сервер '..(controllable and 'разморозил' or 'заморозил') .. ' персонажа')
    end
end
function sampev.onSetPlayerSkin(playerId, skinId)
    if playerId == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
        if imguitable.tgchangeskin[0] then
            sendTelegramMsg('Сервер изменил скин на '..skinId..' ID')
        end
    end
end
function sampev.onPlayerDeath(playerId)
    if playerId == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
        if imguitable.tgplayerdied[0] then
            sendTelegramMsg('Персонаж умер!')
        end
    end
end
function sampev.onSendSpawn()
    if imguitable.tgplayerspawn[0] then
        sendTelegramMsg('Персонаж был заспавнен!')
    end
end
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if imguitable.cautopin[0] then
        if text:find('%{......%}Вы должны подтвердить свой PIN%-код к карточке%.\nВведите свой код в ниже указаную строку:') then
            sampSendDialogResponse(dialogId, 1, nil, ffi.string(imguitable.pinpass))
            return false
        end
    end
    if imguitable.cautoprizes[0] then
        if #text >0 then
            sampSendDialogResponse(dialogId, 1, 0, nil)
            return false
        end
    end
end
function sampev.onServerMessage(color, text)
    if imguitable.cautoprizes[0] then
        if text:find('%[Информация%] %{......%}Вам была выдана Ежедневная награда за ваш онлайн%. Используйте /dw_prizes') then
            sampSendChat('/dw_prizes')
        end
    end
end
function sampev.onSetWeather(weatherId)
    actual.weather = weatherId
    if imguitable.cweather[0] then
        return false
    end
end
function sampev.onSetPlayerTime(hour, minute)
    actual.time = hour
    if imguitable.ctime[0] then
        return false
    end
end
function sampev.onSetWorldTime(hour)
    actual.time = hour
    if imguitable.ctime[0] then
        return false
    end
end
function sampev.onSetInterior(interior)
	if imguitable.ctime[0] then
		setWorldTime(imguitable.stime[0])
	end
	if imguitable.cweather[0] then
		setWorldWeather(imguitable.sweather[0])
	end
end
function sampev.onSendEnterVehicle(vehicleId, passenger)
    if imguitable.cacar[0] and not passenger then
        lua_thread.create(function()
            while not isCharInAnyCar(PLAYER_PED) do wait(100) end
            local result, car = sampGetCarHandleBySampVehicleId(vehicleId)
            if result then
                if not isCarEngineOn(car) then wait(50) sampSendChat('/engine') end
                if getCarDoorLockStatus(car) then wait(250) sampSendChat('/lock') end
                wait(500)
                setVirtualKeyDown(74, true)
	            setVirtualKeyDown(74, false)
            end
        end)
    end
end
