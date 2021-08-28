function [treatdata,buchangdraw]=XRDretreat(rasdata)
    [~,m]=size(rasdata);
    for i=1:m
        newdata=[];
        A=rem(rasdata(i).XRDdata(:,1),1);
        A(A~=0)=-1;
        A(A~=-1)=1;
        A(A~=1)=0;
        newdata1=rasdata(i).XRDdata(:,1).*A;
        newdata2=rasdata(i).XRDdata(:,2).*A;
        newdata11=newdata1(newdata1~=0);
        newdata22=newdata2(newdata2~=0);
        newdata(:,1)=newdata11;
        newdata(:,2)=newdata22;
        treatdata(i).data=newdata;
        buchangdraw(i).data=0;
        buchangdraw(i).drawdata=i*0.1*max(rasdata(i).XRDdata(:,2));
    end
end