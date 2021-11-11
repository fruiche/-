local event = require("event")
local component = require("component")
local sides = require("sides")
local rs = component.redstone
local roomflag, latchflag = false, false --部屋起動とRSlatch起動
local namepair = {"テストマン1","テストマン2"}
local sexpair = {"マン1","マン2"}
local sexcount = 1 --部屋の起動回数
local computer = require("computer")
local starttime, resulttime = 0, 0 --開始時間と完了時間

while true do
    local id, name, x, y, z, playername = event.pull("motion")
    --print(id, x, z, playername)
    
    --print(rs.getInput(sides.back), latchflag, rs.getInput(sides.right), roomflag)
    
    if playername ~= namepair[1] and playername ~= namepair[2] then
        namepair[2] = namepair[1]
        namepair[1] = playername
        --print(namepair[1], namepair[2])
    elseif playername == namepair[2] then
        local tmp = namepair[1]
        namepair[1] = namepair[2]
        namepair[2] = tmp
    end
    if rs.getInput(sides.back) ~= 0 then
        latchflag = true    
    else
        latchflag = false
    end
    if rs.getInput(sides.right) ~= 0 and roomflag == false then
        print("--第"..sexcount.."回 セックスしないと出られない部屋開催!--")
        sexpair[1] = namepair[1]
        sexpair[2] = namepair[2]
        print("出場選手は "..sexpair[1].."×" ..sexpair[2] .." です!")
        starttime = computer.uptime()
        roomflag = true
    end
    if roomflag == true and latchflag == true then
        resulttime = computer.uptime()
        print("-----------------F I N I S H !--------------------")
        print(sexpair[1].."×" ..sexpair[2] .."ペアの\nフィニッシュタイムは"..resulttime-starttime.."秒でした!")
        print("またのご利用をお待ちしております!")
        print("--------------------------------------------------")
        roomflag = false
        sexcount = sexcount + 1
    end
    if roomflag == true and rs.getInput(sides.right) == 0 then
        print("セックスしないと出られない部屋が異常終了しました")
        roomflag = false
    end
end
