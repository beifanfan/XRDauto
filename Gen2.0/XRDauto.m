function varargout = XRDauto(varargin)
% XRDAUTO MATLAB code for XRDauto.fig
%      XRDAUTO, by itself, creates a new XRDAUTO or raises the existing
%      singleton*.
%
%      H = XRDAUTO returns the handle to a new XRDAUTO or the handle to
%      the existing singleton*.
%
%      XRDAUTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XRDAUTO.M with the given input arguments.
%
%      XRDAUTO('Property','Value',...) creates a new XRDAUTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before XRDauto_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to XRDauto_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help XRDauto

% Last Modified by GUIDE v2.5 01-Aug-2021 20:26:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @XRDauto_OpeningFcn, ...
                   'gui_OutputFcn',  @XRDauto_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before XRDauto is made visible.
function XRDauto_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to XRDauto (see VARARGIN)

% Choose default command line output for XRDauto
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes XRDauto wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.Floderedit.String='文件夹路径';
handles.state=0;
handles.buttondown=0;
handles.loadtime=0;
handles.originstate=0;
guidata(hObject,handles);

% --- Outputs from this function are returned to the command line.
function varargout = XRDauto_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Rasloadbutton.
function Rasloadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Rasloadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pathofras=XRDrasfind();
handles.rasdata=XRDrasteat(handles.pathofras);
handles.Floderedit.String=handles.pathofras.list(1).Folderpath;
pathlist=pathchange(handles.pathofras);
handles.Drawchoicetable.Data=pathlist;
%handles.Drawchoicetable.Data=pathlist;
handles.state=1;
handles.loadtime=handles.loadtime+1;
if(handles.loadtime==1)
    handles.Drawchoicetable.ColumnWidth={300};
end
[handles.treatdata,handles.buchangdraw]=XRDretreat(handles.rasdata);
guidata(hObject,handles);

function Floderedit_Callback(hObject, eventdata, handles)
% hObject    handle to Floderedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Floderedit as text
%        str2double(get(hObject,'String')) returns contents of Floderedit as a double


% --- Executes during object creation, after setting all properties.
function Floderedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Floderedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in Drawchoicetable.
function Drawchoicetable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Drawchoicetable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.Drawchoice=eventdata.Indices;
if(isempty(handles.Drawchoice))
    handles.Drawchoice=[1 1];
else
    axes(handles.axes1); %指定需要清空的坐标轴
    cla reset;
    box on; %在坐标轴四周加上边框
    handles.showdata=[];
    [handles.drawcanshu.maxy,handles.drawcanshu.miny,handles.drawcanshu.maxx,handles.drawcanshu.minx,handles.treatdata2,handles.buchangdraw]=drawXRD(handles.rasdata,handles.Drawchoice(:,1),handles.treatdata,handles.buchangdraw);
    handles.showdata(:,1)=handles.rasdata(handles.Drawchoice(1,1)).XRDdata(:,1);
    handles.showdata(:,2)=handles.rasdata(handles.Drawchoice(1,1)).XRDdata(:,2)+handles.buchangdraw(handles.Drawchoice(1,1)).data+handles.buchangdraw(handles.Drawchoice(1,1)).drawdata;
    handles.datatable.ColumnWidth={40};
    handles.state=2;
end

guidata(hObject,handles);
    


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.state==2)
    handles.buttonpoint=get(gca,'CurrentPoint');
    if(handles.buttonpoint(1,1)>handles.drawcanshu.minx&&handles.buttonpoint(1,1)<handles.drawcanshu.maxx&&handles.buttonpoint(1,2)>handles.drawcanshu.miny&&handles.buttonpoint(1,2)<handles.drawcanshu.maxy)
        handles.buttondown=1;
        handles.buttonchoice=pointfind(handles.treatdata2,handles.buttonpoint,handles.Drawchoice(:,1));
    end
end
guidata(hObject,handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.buttondown=0;
guidata(hObject,handles);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.buttondown==1&&handles.state==2)
    handles.currentpoint=get(gca,'CurrentPoint');
    if(handles.currentpoint(1,2)>handles.buttonpoint(1,2))
        [handles.buchangdraw,move]=drawxiuzheng(handles.buttonchoice,handles.drawcanshu,1,handles.buttonpoint,handles.currentpoint,handles.buchangdraw,handles.slider2.Value);
        if(move==1)
            axes(handles.axes1); %指定需要清空的坐标轴
            cla reset;
            box on; %在坐标轴四周加上边框
            [handles.drawcanshu.maxy,handles.drawcanshu.miny,handles.drawcanshu.maxx,handles.drawcanshu.minx,handles.treatdata2,handles.buchangdraw]=drawXRD(handles.rasdata,handles.Drawchoice(:,1),handles.treatdata,handles.buchangdraw);
        end
    else
        [handles.buchangdraw,move]=drawxiuzheng(handles.buttonchoice,handles.drawcanshu,-1,handles.buttonpoint,handles.currentpoint,handles.buchangdraw,handles.slider2.Value);
        if(move==1)
            axes(handles.axes1); %指定需要清空的坐标轴
            cla reset;
            box on; %在坐标轴四周加上边框
            [handles.drawcanshu.maxy,handles.drawcanshu.miny,handles.drawcanshu.maxx,handles.drawcanshu.minx,handles.treatdata2,handles.buchangdraw]=drawXRD(handles.rasdata,handles.Drawchoice(:,1),handles.treatdata,handles.buchangdraw);
        end
    end
end
guidata(hObject,handles);


% --- Executes on button press in resetbutton.
function resetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[~,m]=size(handles.buchangdraw);
for i=1:m
    handles.buchangdraw(i).data=0;
end
guidata(hObject,handles);


% --- Executes on button press in Copybutton.
function Copybutton_Callback(hObject, eventdata, handles)
% hObject    handle to Copybutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileID = fopen('copy.txt','w');
fprintf(fileID,'%6.2f %12.8f\n',handles.showdata');
text = fileread('copy.txt');
clipboard('copy', text );




% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in InOrigin.
function InOrigin_Callback(hObject, eventdata, handles)
% hObject    handle to InOrigin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.originstate==0)
        %初始化Origin
    handles.originObj = actxserver('Origin.ApplicationSI');   % 获得Origin自动化服务对象（通过COM接口）
    invoke(handles.originObj, 'Execute', 'doc -mc 1;');       % 操作可视化
    invoke(handles.originObj, 'IsModified', 'false'); 
    handles.originstate=1;
    strBook = invoke(handles.originObj, 'CreatePage', 2, 'MatlabXRDout', 'Origin');
end
if(handles.originstate)
    if(~isempty(handles.Drawchoice))
        wks = invoke(handles.originObj, 'FindWorksheet', '[MatlabXRDout]Sheet1');
        if(isempty(wks))
            strBook = invoke(handles.originObj, 'CreatePage', 2, 'MatlabXRDout', 'Origin');
            wks = invoke(handles.originObj, 'FindWorksheet', '[MatlabXRDout]Sheet1');
        end
        wks.Activate;
        [m,~]=size(handles.Drawchoice);
        for i=1:m
            transferdata=[];
            k=wks.Columns.count+1;
            transferdata(:,1)=handles.rasdata(handles.Drawchoice(i,1)).XRDdata(:,1);
            transferdata(:,2)=handles.rasdata(handles.Drawchoice(i,1)).XRDdata(:,2)+handles.buchangdraw(handles.Drawchoice(i,1)).data+handles.buchangdraw(handles.Drawchoice(i,1)).drawdata;
            invoke(handles.originObj, 'PutWorksheet', '[MatlabXRDout]Sheet1', transferdata,0,wks.Columns.count);
            handles.originObj.Execute(['wks.col',num2str(k),'.Unit$=deg']);
            handles.originObj.Execute(['wks.col',num2str(k),'.lname$=2 Theta']);
            handles.originObj.Execute(['wks.col',num2str(k+1),'.Unit$=a.u.']);
            handles.originObj.Execute(['wks.col',num2str(k+1),'.lname$=Intensity']);
            handles.originObj.Execute(['wks.col',num2str(k),'.type=4']);
            handles.originObj.Execute(['wks.col',num2str(k+1),'.type=1']);
            [~,n]=size(handles.rasdata(handles.Drawchoice(i,1)).rasname);
            handles.originObj.Execute(['wks.col',num2str(k+1),'.Comment$=',handles.rasdata(handles.Drawchoice(i,1)).rasname(:,1:n-4)]);
        end
    end
    
    
end
guidata(hObject,handles);