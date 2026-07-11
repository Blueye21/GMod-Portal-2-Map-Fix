function Min(num1,num2)
	if num1 < num2 then
		return num1
	else
		return num2	
	end
end

function Abs(num)
	if num < 0 then
		return -1.0*num
	else
		return num	
	end
end

// --------------------------------------------------------
// StartRipple
// --------------------------------------------------------
function StartRipple(start,width,height)
	for i=1,width-1 do
		for j=1,height-1 do
			local panelNum = start + width*j + i
			local time = Abs(0.15*(i-((width-1)/2.0))*(j-((height-1)/2.0)))
			EntFire("panel_flip_" .. panelNum .. "-panel_flip","Trigger", "", time)
		end
	end
end

// --------------------------------------------------------
// StartRipple2
// --------------------------------------------------------
function StartRipple2(start,width,height)
	for i=1,width-1 do
		for j=1,height-1 do
			local panelNum = start + width*j + i
			local time = 0.1*(height*i + 6.0*Abs((j-((height-1)/2.0))) )
			EntFire("panel_flip_" .. panelNum .. "-panel_flip","Trigger", "", time)
		end
	end
end


// --------------------------------------------------------
// StartRipple3
// --------------------------------------------------------
function StartRipple3(start,width,height)
	for i=1,width-1 do
		for j=1,height-1 do
			local panelNum = start + width*j + i
			local time = math.Rand(0,4.0)
			EntFire("panel_flip_" .. panelNum .. "-panel_flip","Trigger", "", time)
		end
	end
end