function flag=pointfind(treatdata,buttonpoint,Drawchoice)

xpoint=floor(buttonpoint(1,1));
ypoint=buttonpoint(1,2);
mindy=100000000000000000000000;
[m,~]=size(Drawchoice);
flag=1;
for i=1:m
    p=find(treatdata(Drawchoice(i)).data(:,1)==xpoint);
    if(abs(ypoint-treatdata(Drawchoice(i)).data(p,2))<mindy)
        flag=Drawchoice(i);
        mindy=abs(ypoint-treatdata(Drawchoice(i)).data(p,2));
    end
end
end