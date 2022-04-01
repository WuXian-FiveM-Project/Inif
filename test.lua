--[[
a=1 --哎嘿 我可以写东西在这
b=1
if a==b then
    print("a is equal b!")
end
]]--


--[[

local Best_Score = 80 -- --牛逼的分数
local Pass_Score = 50 --及格分
local Tim_score = 10 --小可爱-Tim酱的分数


print("Tim scores is "..Tim_score)

if Tim_score >= Best_Score then
    print("niubility")
elseif Tim_score >= Pass_Score then
    print("pass")
else
    print("not pass")
end
    


-- 题目：判定 小可爱-Tim酱 的成绩。如果及格就输出pass，如果牛逼，就输出niubility，
--否则输出不及格    

]]--



function a(...)
    local b = {...}
    print(b[3])
end

a(1,2,3,4)