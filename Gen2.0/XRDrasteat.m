function rasdata=XRDrasteat(pathofras)
[~,numofras]=size(pathofras.list);
for i=1:numofras
    rasdata(i).Leftrange=5;
    rasdata(i).Rightrange=80;
end
for i=1:numofras
    fid=fopen(pathofras.list(i).raspath,'r');
    for j=1:300
        k=textscan(fid,'%s%s%s%s%s%s',1);
        if(strcmp(k{1,1}{1,1},'*DISP_RANGE_LEFT'))
            [~,m]=size(k{1,2}{1,1});
            rasdata(i).Leftrange=str2num(k{1,2}{1,1}(1,2:m-1));
        elseif(strcmp(k{1,1}{1,1},'*DISP_RANGE_RIGHT'))
            [~,m]=size(k{1,2}{1,1});
            rasdata(i).Rightrange=str2num(k{1,2}{1,1}(1,2:m-1));
        elseif(strcmp(k{1,1}{1,1},'*RAS_INT_START'))
            break
        end
    end
    data=[];
    k=textscan(fid,'%12.8f %12.8f %12.8f',1);
    data(1,1:2)=[k{1,1},k{1,2}];
    k=textscan(fid,'%12.8f %12.8f %12.8f',1);
    data(2,1:2)=[k{1,1},k{1,2}];
    step=data(2,1)-data(1,1);
    alllength=floor((rasdata(i).Rightrange-rasdata(i).Leftrange)/step-1);
    kk=textscan(fid,'%12.8f %12.8f %12.8f',alllength);
    data(3:alllength+2,1)=kk{1,1};
    data(3:alllength+2,2)=kk{1,2};
    rasdata(i).XRDdata=data;
    rasdata(i).rasname=pathofras.list(i).name;
    fclose(fid);
end





end