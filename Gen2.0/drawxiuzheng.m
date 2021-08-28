function [buchangdraw,move]=drawxiuzheng(flag,drawcanshu,upordown,clickpoint,currentpoint,buchangdraw,step)
move=0;
if(abs(currentpoint(1,2)-clickpoint(1,2))>0.01*(drawcanshu.maxy-drawcanshu.miny))
    buchangdraw(flag).data=buchangdraw(flag).data+step*(drawcanshu.maxy-drawcanshu.miny)*upordown;
    move=1;
end

end