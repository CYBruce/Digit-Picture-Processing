function varargout = homework(varargin)
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

% Last Modified by GUIDE v2.5 25-Jun-2018 20:22:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @homework_OpeningFcn, ...
                   'gui_OutputFcn',  @homework_OutputFcn, ...
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
function homework_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homework3 (see VARARGIN)

% Choose default command line output for homework3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes homework3 wait for user response (see UIRESUME)
% uiwait(handles.figure_1);


% --- Outputs from this function are returned to the command line.
function varargout = homework_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------


% --------------------------------------------------------------------



% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(...
    {'*.bmp;*.jpg;*.png;*.jpeg','Image Files (*.bmp;*.jpg;*.png;*.jpeg)';...
    '*.*', 'All Files (*.*)'}, ...
    'Pick an image');%选择打开文件的路径
%确定是否正确打开
if isequal(filename,0)||isequal(pathname,0)
    return;
end
axes(handles.axes1);%确定要操作的坐标轴
fpath=[pathname filename];
global img_src;%全局化变量
global img_src1;
I=imread(fpath);
mysize = size(I);%判断图片是彩色图还是灰度图
if numel(mysize)>2 %如果是彩色图要转换为灰度图
    img_src=rgb2gray(I);
else
    img_src=I;
end
img_src1 = img_src
imshow(img_src);
set(handles.m_file_save,'enable','on') %设置各功能的逻辑关系，打开图片才可以操作
set(handles.back,'enable','on')
set(handles.m_file_exit,'enable','on')
set(handles.m_file_save,'enable','on')
set(handles.noise,'enable','on')
set(handles.filter,'enable','on')
set(handles.edge,'enable','on')
set(handles.im2bw,'enable','on')
set(handles.inverse,'enable','on')
set(handles.histeq,'enable','on')
set(handles.exponent,'enable','on')
set(handles.linear,'enable','on')
set(handles.frequency,'enable','on')
set(handles.devide,'enable','on')
global m_handles
m_handles=handles
global height0  %建立图片的堆栈 
global width0
height0=size(img_src1,1)
width0=size(img_src1,2)
global my_stack
my_stack = zeros(height0,width0,3)  %设置堆栈大小为3
global my_pointer  %设置指针
global bottom  %设置堆栈边界
my_pointer = 1 %初始化指针和边界
bottom = 1
my_stack(:,:,1)= img_src1
% --------------------------------------------------------------------
function m_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1; %保存该图片
[FileName,PathName]=uiputfile({'*.bmp';'*.jpg';'*.gif'});
if  FileName ~= 0
    path=[PathName,FileName];
    imwrite(img_src1,path);
end


% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure_1);%退出菜单


% --------------------------------------------------------------------
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src;
global img_src1;
img_src1=img_src     %返回图片初始状态
axes(handles.axes1);
imshow(img_src);     


% --------------------------------------------------------------------
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=noise;


% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=homework3;

% --- Executes on button press in im2bw.
function im2bw_Callback(hObject, eventdata, handles)
% hObject    handle to im2bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
h=im2bw_args();

% --- Executes on button press in inverse.
function inverse_Callback(hObject, eventdata, handles)
% hObject    handle to inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
axes(handles.axes1);%确定要操作的坐标轴
img_src1=255-img_src1;   %反相操作
imshow(img_src1,[]);

% --- Executes on button press in histeq.
function histeq_Callback(hObject, eventdata, handles)
% hObject    handle to histeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=histshow


% --- Executes on button press in exponent.
function exponent_Callback(hObject, eventdata, handles)
% hObject    handle to exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=nonlinear;

% --- Executes on button press in linear.
function linear_Callback(hObject, eventdata, handles)
% hObject    handle to linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=Linear_transformation;


% --- Executes on button press in binary_shape.
function binary_shape_Callback(hObject, eventdata, handles)
% hObject    handle to binary_shape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=binary_shape;


% --------------------------------------------------------------------
function information_Callback(hObject, eventdata, handles)
% hObject    handle to information (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function hist_Callback(hObject, eventdata, handles)
% hObject    handle to hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=FDfilter;

% --- Executes on button press in devide.
function devide_Callback(hObject, eventdata, handles)
% hObject    handle to devide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=devide;


% --------------------------------------------------------------------
function uitoggletool5_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitoggletool5_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitoggletool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(...
    {'*.bmp;*.jpg;*.png;*.jpeg','Image Files (*.bmp;*.jpg;*.png;*.jpeg)';...
    '*.*', 'All Files (*.*)'}, ...
    'Pick an image');%选择打开文件的路径
%确定是否正确打开
if isequal(filename,0)||isequal(pathname,0)
    return;
end
axes(handles.axes1);%确定要操作的坐标轴
fpath=[pathname filename];
global img_src;%全局化变量
global img_src1;
I=imread(fpath);
mysize = size(I);%判断图片是彩色图还是灰度图
if numel(mysize)>2
    img_src=rgb2gray(I);
else
    img_src=I;
end
img_src1 = img_src
imshow(img_src);
set(handles.m_file_save,'enable','on')
set(handles.back,'enable','on')
set(handles.m_file_exit,'enable','on')
set(handles.m_file_save,'enable','on')
set(handles.noise,'enable','on')
set(handles.filter,'enable','on')
set(handles.edge,'enable','on')
set(handles.im2bw,'enable','on')
set(handles.inverse,'enable','on')
set(handles.histeq,'enable','on')
set(handles.exponent,'enable','on')
set(handles.linear,'enable','on')
set(handles.frequency,'enable','on')
set(handles.devide,'enable','on')
global m_handles
m_handles=handles
global height0
global width0
height0=size(img_src1,1)
width0=size(img_src1,2)
global my_stack
my_stack = zeros(height0,width0,3)
global my_pointer
global bottom
my_pointer = 1
bottom = 1
my_stack( :, :,1)= img_src1

% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1;
[FileName,PathName]=uiputfile({'*.bmp';'*.jpg';'*.gif'});
if  FileName ~= 0
    path=[PathName,FileName];
    imwrite(img_src1,path);
end
% --------------------------------------------------------------------


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function figure_1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
global height0
global width0
axes(handles.axes1);                     %坐标轴定位并获取坐标点
pt = get(gca,'CurrentPoint');
x = fix(pt(1,1));
y = fix(pt(1,2));
if x > width0                   %鼠标点边界判断，防止点过图片边界   
    x = width0;
end
if x < 0
    x = 0+1;
end
if y > height0 
    y = height0;
end
if y < 0
    y = 0+1;
end
%设置图片像素信息展示
set(handles.text13,'String',strcat('灰度值信息','(',num2str(x),',',num2str(y),')=',num2str(img_src1(y,x))));
%注意是先行后列，像素数据行代表的y，列代表的是x
% --------------------------------------------------------------------
function Return_Callback(hObject, eventdata, handles)
% hObject    handle to Return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global my_stack
global my_pointer
global bottom
my_pointer = my_pointer+1
global img_src1
global img_src
img_src1 = my_stack(:,:,my_pointer)
axes(handles.axes1)
imshow(img_src1,[])  %设置撤回和反撤回的逻辑
set(handles.recover,'enable','on')
if my_pointer == bottom  %如果到达堆栈边界，则不能继续撤回
    set(handles.Return,'enable','off')
end

% --------------------------------------------------------------------
function recover_Callback(hObject, eventdata, handles)
% hObject    handle to recover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global my_pointer
global img_src1
global my_stack
set(handles.Return,'enable','on')
if my_pointer == 2  %如果到达堆栈边界，则不能继续反撤回
    set(handles.recover,'enable','off')
end
if my_pointer >= 2
    axes(handles.axes1)
    my_pointer=my_pointer-1
    imshow(my_stack(:,:,my_pointer),[])
end


% --- Executes on mouse press over figure background.
function figure_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
