function varargout = homework3(varargin)
% HOMEWORK3 MATLAB code for homework3.fig
%      HOMEWORK3, by itself, creates a new HOMEWORK3 or raises the existing
%      singleton*.
%
%      H = HOMEWORK3 returns the handle to a new HOMEWORK3 or the handle to
%      the existing singleton*.
%
%      HOMEWORK3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMEWORK3.M with the given input arguments.
%
%      HOMEWORK3('Property','Value',...) creates a new HOMEWORK3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before homework3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to homework3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help homework3

% Last Modified by GUIDE v2.5 20-Jun-2018 09:06:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @homework3_OpeningFcn, ...
                   'gui_OutputFcn',  @homework3_OutputFcn, ...
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


% --- Executes just before homework3 is made visible.
function homework3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homework3 (see VARARGIN)

% Choose default command line output for homework3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global img_src1 
axes(handles.axes1);   %坐标轴定位，初始化显示图像
imshow(img_src1);
% UIWAIT makes homework3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = homework3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function sobel_Callback(hObject, eventdata, handles)
% hObject    handle to sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
in = double(img_src1)
edge = uint8(zeros(size(img_src1)));
    h = size(img_src1, 1);
    w = size(img_src1, 2);
    gx = [-1, -2, -1; 0, 0, 0; 1, 2, 1]; %设置x方向的Sobel算子
    gy = gx'; %转置后为y方向的Sobel算子
    for i = 2 : h - 1
        for j = 2 : w - 1
            sub = double(img_src1(i - 1 : i + 1, j - 1 : j + 1));
            g1 = abs(sum(sum(sub .* gx)));
            g2 = abs(sum(sum(sub .* gy)));%进行卷积操作
            if g1 > g2
                edge(i, j) = uint8(g1);
            else
                edge(i, j) = uint8(g2);
            end
        end
    end
k = edge
axes(handles.axes1)
imshow(k)
global filter
filter = k

% --------------------------------------------------------------------
function prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
in = double(img_src1)
edge = uint8(zeros(size(in)));
    h = size(in, 1);
    w = size(in, 2);
    gx = [-1, -1, -1; 0, 0, 0; 1, 1, 1];
    gy = gx';
    for i = 2 : h - 1
        for j = 2 : w - 1
            sub = double(in(i - 1 : i + 1, j - 1 : j + 1));%同理，设置prewitt算子
            g1 = abs(sum(sum(sub .* gx)));
            g2 = abs(sum(sum(sub .* gy)));
            if g1 > g2
                edge(i, j) = uint8(g1);
            else
                edge(i, j) = uint8(g2);
            end
        end
    end

axes(handles.axes1)
imshow(uint8(edge))
global filter
filter = edge

% --------------------------------------------------------------------

% --------------------------------------------------------------------
function median3_Callback(hObject, eventdata, handles)
% hObject    handle to median3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 3;  
[ height, width ] = size(img_src1);
    x1 = double(img_src1);
    x2 = x1;
    for i = 1: height-n+1
        for j = 1:width-n+1
            mb = x1( i:(i+n-1),  j:(j+n-1) );
            mb = mb(:);
            mm = median(mb);
            x2( i+(n-1)/2,  j+(n-1)/2 ) = mm;
        end
    end
k = uint8(x2);
imshow(uint8(k));
global filter
filter = k

% --------------------------------------------------------------------
function median5_Callback(hObject, eventdata, handles)
% hObject    handle to median5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 5;  
[height,width] = size(img_src1);
    x1 = double(img_src1);
    x2 = x1;
    for i = 1:height-n+1
        for j =1:width-n+1
            mb = x1( i:(i+n-1),j:(j+n-1) );
            mb = mb(:);
            mm = median(mb);
            x2( i+(n-1)/2,j+(n-1)/2 ) = mm;
        end
    end
k = uint8(x2);
imshow(uint8(k));
global filter
filter = k

% --------------------------------------------------------------------
function median7_Callback(hObject, eventdata, handles)
% hObject    handle to median7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 7;  
[ height, width ] = size(img_src1);
    x1 = double(img_src1);
    x2 = x1;
    for i = 1: height-n+1
        for j = 1:width-n+1
            mb = x1( i:(i+n-1),  j:(j+n-1) );
            mb = mb(:);
            mm = median(mb);
            x2( i+(n-1)/2,  j+(n-1)/2 ) = mm;
        end
    end

k = uint8(x2);
imshow(uint8(k));
global filter
filter = k

% --------------------------------------------------------------------
function median9_Callback(hObject, eventdata, handles)
% hObject    handle to median9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 9;  
[ height, width ] = size(img_src1);
    x1 = double(img_src1);
    x2 = x1;
    for i = 1: height-n+1
        for j = 1:width-n+1
            mb = x1( i:(i+n-1),  j:(j+n-1) );
            mb = mb(:);
            mm = median(mb);
            x2( i+(n-1)/2,  j+(n-1)/2 ) = mm;
        end
    end

k = uint8(x2);
imshow(uint8(k));
global filter
filter = k
% --------------------------------------------------------------------
function average3_Callback(hObject, eventdata, handles)
% hObject    handle to average3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 3;  
template = ones(n);  
[height, width] = size(img_src1);  
x1 = double(img_src1);  
x2 = x1;  
for i = 1:height-n+1  
    for j = 1:width-n+1  
        c = x1(i:i+n-1,j:j+n-1).*template;  
        s = sum(sum(c));  
        x2(i+(n-1)/2,j+(n-1)/2) = s/(n*n);  
    end  
end  
k = uint8(x2);
imshow(uint8(k));
global filter
filter = k

% --------------------------------------------------------------------
function average5_Callback(hObject, eventdata, handles)
% hObject    handle to average5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 5;  
template = ones(n);  
[height, width] = size(img_src1);  
x1 = double(img_src1);  
x2 = x1;  
for i = 1:height-n+1  
    for j = 1:width-n+1  
        c = x1(i:i+n-1,j:j+n-1).*template;  
        s = sum(sum(c));  
        x2(i+(n-1)/2,j+(n-1)/2) = s/(n*n);  
    end  
end  
k = uint8(x2);
imshow(uint8(k));
global filter
filter = k

% --------------------------------------------------------------------
function average7_Callback(hObject, eventdata, handles)
% hObject    handle to average7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
n = 7;  
template = ones(n);  
[height, width] = size(img_src1);  
x1 = double(img_src1);  
x2 = x1;  
for i = 1:height-n+1  
    for j = 1:width-n+1  
        c = x1(i:i+n-1,j:j+n-1).*template;  
        s = sum(sum(c));  
        x2(i+(n-1)/2,j+(n-1)/2) = s/(n*n);  
    end  
end  
k = uint8(x2);
imshow(uint8(k));
global filter
filter = k

% --------------------------------------------------------------------
function average9_Callback(hObject, eventdata, handles)
% hObject    handle to average9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter
global img_src1;
n = 9;  
template = ones(n);  
[height, width] = size(img_src1);  
x1 = double(img_src1);  
x2 = x1;  
for i = 1:height-n+1  
    for j = 1:width-n+1  
        c = x1(i:i+n-1,j:j+n-1).*template;  
        s = sum(sum(c));  
        x2(i+(n-1)/2,j+(n-1)/2) = s/(n*n);  
    end  
end  
k = uint8(x2);
filter = k
imshow(uint8(k));

% --------------------------------------------------------------------
function customize_Callback(hObject, eventdata, handles)
% hObject    handle to customize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter
%自定义滤波
b=get(handles.uitable,'data');
global img_src1;
axes(handles.axes1);%确定要操作的坐标轴
[height, width] = size(img_src1);  
x1 = double(img_src1);  
x2 = x1;  
n=min(size(b));%滤波模板尺寸
for i = 1:height-n+1  
    for j = 1:width-n+1  
        c = x1(i:i+n-1,j:j+n-1).*b;  
        s = sum(sum(c));  
        x2(i+(n-1)/2,j+(n-1)/2) = s/(n*n);  
    end  
end  
k = uint8(x2);
filter = k
imshow(uint8(k));


% --------------------------------------------------------------------
function laplace_Callback(hObject, eventdata, handles)
% hObject    handle to laplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
global filter
in = double(img_src1)
edge = uint8(zeros(size(in)));
    h = size(in, 1);
    w = size(in, 2);
    l = [0, 1, 0; 1, -4, 1; 0, 1, 0];
    for i = 2 : h - 1
        for j = 2 : w - 1
            sub = double(in(i - 1 : i + 1, j - 1 : j + 1));
            d = sum(sum(sub .* l));
            edge(i, j) = uint8(d);
        end
    end
filter = edge
axes(handles.axes1)
imshow(uint8(edge))


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter
global img_src1
global m_handles
img_src1 = filter
axes(m_handles.axes1)
imshow(filter)
close(handles.figure1)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a11=str2double(get(handles.edit11,'string'));     % 读取eidt中的字符串，并转化为数字
a12=str2double(get(handles.edit12,'string'));
set(handles.uitable,'data',ones(a11,a12));