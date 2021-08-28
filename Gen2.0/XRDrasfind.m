function pathofras=XRDrasfind()
selpath = uigetdir;
if(selpath~=0)
    pathofras.data(1).Folderpath=selpath;
    filepaths = dir(fullfile(selpath,'*.ras'));
    [m,~]=size(filepaths);
    for i=1:m
        pathofras.data(1).rasdata(i).bytes=filepaths(i).bytes;
        pathofras.data(1).rasdata(i).name=filepaths(i).name;
        pathofras.data(1).rasdata(i).DTApath=[filepaths(i).folder,'\',filepaths(i).name];
        pathofras.data(1).rasdata(i).Id=i;
        pathofras.list(i).Ceng=0;
        pathofras.list(i).raspath=[filepaths(i).folder,'\',filepaths(i).name];
        pathofras.list(i).Folderpath=selpath;
        pathofras.list(i).bytes=filepaths(i).bytes;
        pathofras.list(i).name=filepaths(i).name;
        pathofras.list(i).Id=i;
    end
else
    path=[];
end
end