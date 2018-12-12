function varargout = Linear_transformation(varargin)
% LINEAR_TRANSFORMATION MATLAB code for Linear_transformation.fig
%      LINEAR_TRANSFORMATION, by itself, creates a new LINEAR_TRANSFORMATION or raises the existing
%      singleton*.
%
%      H = LINEAR_TRANSFORMATION returns the handle to a new LINEAR_TRANSFORMATION or the handle to
%      the existing singleton*.
%
%      LINEAR_TRANSFORMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINEAR_TRANSFORMATION.M with the given input arguments.
%
%      LINEAR_TRANSFORMATION('Property','Value',...) creates a new LINEAR_TRANSFORMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Linear_transformation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Linear_transformation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Linear_transformation

% Last Modified by GUIDE v2.5 27-Jun-2018 11:08:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Linear_transformation_OpeningFcn, ...
                   'gui_OutputFcn',  @Linear_transformation_OutputFcn, ...
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


% --- Executes just before Linear_transformation is made visible.
function Linear_transformation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Linear_transformation (see VARARGIN)

% Choose default command line output for Linear_transformation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Linear_transformation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Linear_transformation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%全局变量定义并初始化变量 

global Handle       %全局句柄
global point_copy   %还没排序的点集合
global point        %已经排序的点集合
global img_src1          %图像

global IsPressed     %是否按下鼠标标志
global HasMove       %是否移动鼠标标志
global IsEndpoint    %是否为曲线端点标志
global IsFirstMove   %是否为鼠标按下时第一次移动鼠标标志
Handle=handles;
 
axes(Handle.axes2);   %坐标轴定位，初始化显示图像
imshow(img_src1);


IsPressed = false;    %变量初始化
HasMove=false;
IsEndpoint=false;
IsFirstMove=true;

point=[,];           %曲线点集合初始化，初始化为起点和端点
point(1,:)=[0,0];
point(2,:)=[255,255];
point_copy = point;

axes(Handle.axes1);    %坐标轴重新定位，设置坐标轴属性，并绘画曲线
line([0,255],[0,255]);
set(Handle.axes1,'XTick',[0,20,40,60,80,100,120,140,160,180,200,220,240,260]);
set(Handle.axes1,'YTick',[0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260]);

set(Handle.uitable1,'data',point);   %显示表格内容

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%鼠标移动函数
function ButttonMotionFcn(src,event)
    cla;
    global point
    global point_copy
    global IsPressed 
    global HasMove
    global IsEndpoint
    global IsFirstMove
    global np
    global Handle
    pt = get(gca,'CurrentPoint'); %获取当前鼠标坐标位置
    x = pt(1,1);
    y = pt(1,2);
   
    if x > 255                   %鼠标点边界判断，防止点过坐标轴边界   
        x = 255-1;
    end
    if x < 0
        x = 0+1;
    end
    if y > 255 
        y = 255;
    end
    if y < 0
        y = 0;
    end

       
    if IsPressed ==1 && HasMove ==0   %左键按下且刚开始移动鼠标
       
        %......1）先判断点击的是否是已知点
        %......2）若是，在集合中先删除已知点，再把新增的点加进来；
        %......3）若不是，则直接添加新增点
        t=Is_Neighbor(point_copy,x,y);  %判断是不是点击了曲线的集合点 t—返回该点在集合中下标，t=0表示没有点击集合点
        if t ~=0
            if point_copy(t,1)==0       %点击了起点，限制点只能在x=0上下移动  
                x=0;
                IsEndpoint=true;
            end
            if point_copy(t,1)==255    %点击了终点，限制点只能在x=255上下移动            
                x=255;
                IsEndpoint=true;
            end
            point_copy(t,:)=[];         %删除原来存在的点   
        end
        point_copy =[point_copy;x,y];   %把新点添加进集合
        HasMove=true;
        
    end
    
    if IsPressed ==1 && HasMove ==1     %鼠标按下且已经移动鼠标中     
        %....1)判断是否是移动端点
        %....2)若是，则只需要改变y值
        %....3)若不是，则需要改变x,y值
        if IsEndpoint==0                
            point_copy(end,1:2)=[x,y];
        end
        if IsEndpoint==1
            point_copy(end,2)=[y];
        end
    end
    temp = uint8(point_copy)
    point = temp;
    point=sortrows(point,1);   %先对集合中的点根据X值进行排序
    draw_line(point);          %画点
    set(Handle.uitable1,'data',point);  %更新table表的值
    
%判断point集合中是否有(x,y)点，若有，则返回其下标集合
function num = Is_Same_Point(point,x,y)    
    num=[];
    for i=1:size(point,1)
        if point(i,1:2)==[x,y]
            num=[num;i];
        end
    end

%获取point集合是与点（x,y）距离小于10个单位的点，返回距离最小点的下标
function Id = Is_Neighbor(point,x,y)
    num=[];
    for i=1:size(point,1)
        x1=point(i,1);
        y1=point(i,2);
        H=sqrt((x1-x)^2+(y1-y)^2);
        if H < 20
           num=[num;i,H];
        end       
    end
    if isempty(num) ~=1
        num=sortrows(num,2);
        Id=num(1,1);
    end
    if isempty(num) ==1
        Id=0;
    end
    
%返回集合point中与x相邻两点的横坐标   
function P=find_Neighbour_Point(point,x)  
c_point=sortrows(point,1);
for i=1:size(c_point,1)-1
    if c_point(i,1)<= x && c_point(i+1,1)>=x
        x1=c_point(i,1);
        x2=c_point(i+1,1);
        P=[x1,x2];
        break;
    end
end

%绘画曲线图
function draw_line(point)
    cla;
    for i=1:size(point,1)-1
        x=[point(i,1),point(i+1,1)];
        y=[point(i,2),point(i+1,2)];
        line(x,y);
    end    

%图像线性变换，变换函数为分段函数
function linear_transformation()
global img_src1
global point_copy
global I
I=img_src1;
I=double(I);
[M,N]=size(I);
len=size(point_copy,1);
point=point_copy;
point=sortrows(point,1);
for i=1:M
    for j=1:N
        for k=1:len-1
            s1=point(k,1);
            t1=point(k,2);
            s2=point(k+1,1);
            t2=point(k+1,2);
            if I(i,j)>=s1 && I(i,j)<=s2
                I(i,j)=(t2-t1)/(s2-s1)*(I(i,j)-s1)+t1;
                break;
            end
        end
    end
end
I=uint8(I);
global Handle;
axes(Handle.axes2);
imshow(I);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
%鼠标释放时触发的函数
set(gcf,'WindowButtonMotionFcn',@null);  %设置鼠标移动回调函数为空
set(gcf,'Pointer','arrow')               % 设置为箭头的形状
global IsPressed
global HasMove 
global IsEndpoint
global IsFirstMove
global Handle
global point
HasMove = false;
IsPressed = false;
IsEndpoint=false;
IsFirstMove=true;
linear_transformation();
set(Handle.uitable1,'data',point);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%鼠标按下时触发的函数

axes(handles.axes1);                     %坐标轴定位并获取坐标点
pt = get(gca,'CurrentPoint');
x = pt(1,1);
y = pt(1,2);
%fprintf('x=%f,y=%f\n',x,y);
if x > 255 || x < 0 ||y > 255  || y < 0    %超出坐标轴边界不做考虑
    return;
end         

global IsPressed
global point_copy
global point
IsPressed = false;

%1）先判断鼠标右键是否按下，同时删除满足条件的点
p=Is_Neighbor(point_copy,x,y);     %获取距离最近点下标     
if strcmp(get(gcf,'selectiontype'),'alt') && p~=0 && ...  %鼠标右键按下且....
    point_copy(p,1) ~=0 && point_copy(p,1) ~=255
    point_copy(p,:)=[];             %删除该点
    point = point_copy;
    point=sortrows(point,1);
    draw_line(point);              %重绘曲线和图像
    linear_transformation();
    fprintf('x=%f,y=%f\n',x,y);
end

%2）再判断鼠标点和曲线的位置关系，决定是否可以拖动曲线
for i=1:size(point)-1
    x1=double(point(i,1));
    y1=double(point(i,2));
    x2=double(point(i+1,1));
    y2=double(point(i+1,2));
    distance= sqrt((x1-x2)^2+(y1-y2)^2);
    N_distance=sqrt((x1-x)^2+(y1-y)^2)+sqrt((x-x2)^2+(y-y2)^2);
    if abs(N_distance-distance) < 5
        IsPressed = true;
        set(gcf,'Pointer','hand') ;                         % 设置为手的形状
        set(gcf,'WindowButtonMotionFcn',@ButttonMotionFcn); %设置鼠标移动回调函数为ButttonMotionFcn
    end
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes3

%在CreateFcn函数里面写代码可能会造成控件绘画不成功，从而导致错误
% global img
% imshow(img);
% global Handle
% global point
% set(Handle.uitable1,'data',point);

% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, event, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
% Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

%在点击表内容时，把相应的点击点标记出来
global point
global Handle
p=[];
if ~isempty(event.Indices)
    data=get(hObject,'data');     %获取表格的内容 
    iLine=event.Indices(1);       %行下标
    iColumn=event.Indices(2);     %列下标
    if iColumn==1
        x=data(iLine,iColumn);
        y=data(iLine,iColumn+1);

    else
        x=data(iLine,iColumn-1);
        y=data(iLine,iColumn);
    end
    axes(Handle.axes1);       
    draw_line(point);         %重绘曲线
    hold on;
    plot(x,y,'marker','.','MarkerSize',25); %标记点
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global point_copy 
global point 
point_copy =get(handles.uitable1,'data');
point=point_copy;
point=sortrows(point,1);
draw_line(point );
linear_transformation();


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%在CreateFcn函数下面写以下语句会出问题
%global Handle
% global point
% set(Handle.uitable1,'data',point);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
global Handle
global m_handles
axes(Handle.axes2);
imshow(I);
axes(m_handles.axes1)
imshow(I)
close(handles.figure1)

% --------------------------------------------------------------------
function uitable1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global point
global Handle
p=[];
    data=get(hObject,'data');     %获取表格的内容 
    iLine=eventdata.Indices(1);       %行下标
    iColumn=eventdata.Indices(2);     %列下标
    if iColumn==1
        x=data(iLine,iColumn);
        y=data(iLine,iColumn+1);

    else
        x=data(iLine,iColumn-1);
        y=data(iLine,iColumn);
    end
    temp = point
    temp(iLine,1) = uint8(x)
    temp(iLine,2) = uint8(y)
    point = temp
    axes(Handle.axes1);       
    point=sortrows(point,1);
    draw_line(point);         %重绘曲线
    hold on;
    plot(x,y,'marker','.','MarkerSize',25); %标记点
