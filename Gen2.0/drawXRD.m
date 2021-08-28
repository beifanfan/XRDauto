function [maxy,miny,maxx,minx,treatdata2,buchangdraw]=drawXRD(rasdata,drawchoice,treatdata,buchangdraw)

[m,~]=size(drawchoice);
hold on;
maxy=max(rasdata(drawchoice(1)).XRDdata(:,2))+buchangdraw(drawchoice(1)).data+buchangdraw(drawchoice(1)).drawdata;
miny=min(rasdata(drawchoice(1)).XRDdata(:,2))+buchangdraw(drawchoice(1)).data+buchangdraw(drawchoice(1)).drawdata;
minx=180;
maxx=0;
for i=1:m
    minxx=min(rasdata(drawchoice(i)).XRDdata(:,1));
    maxxx=max(rasdata(drawchoice(i)).XRDdata(:,1));
    maxyy=max(rasdata(drawchoice(i)).XRDdata(:,2))+buchangdraw(drawchoice(i)).data+buchangdraw(drawchoice(i)).drawdata;
    minyy=min(rasdata(drawchoice(i)).XRDdata(:,2))+buchangdraw(drawchoice(i)).data+buchangdraw(drawchoice(i)).drawdata;
    if(minxx<minx)
        minx=minxx;
    end
    if(maxxx>maxx)
        maxx=maxxx;
    end
    if(minyy<miny)
        miny=minyy;
    end
    if(maxyy>maxy)
        maxy=maxyy;
    end
    [~,n]=size(rasdata(drawchoice(i)).rasname);
    nameras{i}=rasdata(drawchoice(i)).rasname(1,1:n-4);
end
for i=1:m
    %buchangdraw(drawchoice(i)).drawdata=0.05*(i-1)*maxy;
    plot(rasdata(drawchoice(i)).XRDdata(:,1),rasdata(drawchoice(i)).XRDdata(:,2)+buchangdraw(drawchoice(i)).data+buchangdraw(drawchoice(i)).drawdata);
    treatdata2(drawchoice(i)).data(:,2)=treatdata(drawchoice(i)).data(:,2)+buchangdraw(drawchoice(i)).data+buchangdraw(drawchoice(i)).drawdata;
    treatdata2(drawchoice(i)).data(:,1)=treatdata(drawchoice(i)).data(:,1);
end
hold off
xlim([minx, maxx]);
ylim([miny-0.1*(maxy-miny), maxy+0.1*(maxy-miny)]);
xlabel('2 Theta(deg)','FontSize',12);
ylabel('Intensity(a.u.)','FontSize',12);
hl=legend(nameras,'FontSize',12,'Location','best');
set(hl,'Box','off');
end