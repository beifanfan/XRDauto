function pathlist=pathchange(pathofras)
    [~,m]=size(pathofras.list);
    for i=1:m
        pathlist{i,1}=pathofras.list(i).name;
    end
end