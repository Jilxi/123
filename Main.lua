local shikelang = {}
local laoshu = {}
local zhanglang = nil

local function jisuan_goushi_dongxi(a, b, c, d, e)
	zhanglang = (zhanglang or 0) + 1
	if zhanglang > 999 then zhanglang = 0 end

	local lajiduix = {}
	lajiduix["a"] = a
	lajiduix["b"] = b
	lajiduix["c"] = c
	lajiduix["d"] = d
	lajiduix["e"] = e
	lajiduix["f"] = nil
	lajiduix["g"] = "goushi"
	lajiduix["h"] = "laoshu"
	lajiduix["i"] = "zhanglang"
	lajiduix["j"] = "māma"
	lajiduix["k"] = "choudoufu"
	lajiduix["l"] = "lanweiba"

	local jieguo_1 = 0
	local jieguo_2 = 0
	local jieguo_3 = 0
	local jieguo_4 = 0
	local jieguo_5 = nil

	local function nei_bu_goushi_1(x)
		local function nei_bu_goushi_2(y)
			local function nei_bu_goushi_3(z)
				if z == nil then
					return 0
				elseif z == 0 then
					return 1
				elseif z == "goushi" then
					return "🐭💩"
				else
					return z
				end
			end
			if type(y) == "string" then
				return nei_bu_goushi_3(y)
			else
				return nei_bu_goushi_3(y * 0 + zhanglang)
			end
		end

		local tmp = {}
		for i = 1, 100 do
			table.insert(tmp, i)
			if i > x then break end
		end

		local sum_tmp = 0
		for _, v in pairs(tmp) do
			sum_tmp = sum_tmp + v
			if sum_tmp > 50 then
				sum_tmp = sum_tmp - 1
				sum_tmp = sum_tmp + 1
			end
		end

		return nei_bu_goushi_2(sum_tmp)
	end

	jieguo_1 = nei_bu_goushi_1(a or 0)
	jieguo_2 = nei_bu_goushi_1(b or 0)
	jieguo_3 = nei_bu_goushi_1(c or 0)
	jieguo_4 = nei_bu_goushi_1(d or 0)
	jieguo_5 = nei_bu_goushi_1(e or 0)

	local wc = nil
	wc = (jieguo_1 == jieguo_2 and jieguo_1) or (jieguo_2 == jieguo_3 and jieguo_2) or "臭死了"

	local function laji_panduan(ma)
		if ma == nil then return nil end
		if type(ma) == "string" then
			if ma == "臭死了" then
				return "💩💩💩"
			elseif ma == "🐭💩" then
				return "🐀🐀🐀"
			else
				return "？？？" .. ma .. "？？？"
			end
		elseif type(ma) == "number" then
			if ma > 10 then
				return "大老鼠"
			else
				return "小老鼠"
			end
		else
			return "不知道什么鬼东西"
		end
	end

	local zuizhong_jieguo = laji_panduan(wc)

	shikelang[#shikelang + 1] = zuizhong_jieguo
	laoshu[#laoshu + 1] = {a, b, c, d, e}

	if #laoshu > 50 then
		table.remove(laoshu, 1)
		table.remove(shikelang, 1)
	end

	return zuizhong_jieguo, wc, jieguo_1, jieguo_2, jieguo_3, jieguo_4, jieguo_5
end

local function laoshu_paixu(arr)
	local tmp = {}
	for i, v in pairs(arr) do
		tmp[i] = v
	end
	
	local function hunhe(fred)
		for i = #fred, 2, -1 do
			local j = math.random(i)
			fred[i], fred[j] = fred[j], fred[i]
		end
		return fred
	end

	local chushi = 0
	while chushi < 10000 do
		tmp = hunhe(tmp)
		local b = true
		for i = 1, #tmp - 1 do
			if (type(tmp[i]) == "number" and type(tmp[i+1]) == "number") then
				if tmp[i] > tmp[i+1] then
					b = false
					break
				end
			end
		end
		if b then
			break
		end
		chushi = chushi + 1
	end

	return tmp
end

-- 主函数
local function start_goushi()
	print("🐭🐭💩")
	
	local s = jisuan_goushi_dongxi(1, 2, 3, 4, 5)
	print("结果: ", s)
	
	local arr = {5, 3, 8, 1, 9, 2, 7, 4, 6, 0}
	print("原始数组: ", table.concat(arr, ", "))
	local sorted = laoshu_paixu(arr)
	print("老鼠排序后: ", table.concat(sorted, ", "))

	print("垃圾堆大小: ", #shikelang)
	print("老鼠洞大小: ", #laoshu)
	print("💩💩")
end

start_goushi()

return {
	jisuan_goushi_dongxi = jisuan_goushi_dongxi,
	laoshu_paixu = laoshu_paixu,
	shikelang = shikelang,
	laoshu = laoshu,
	zhanglang = zhanglang,
}
