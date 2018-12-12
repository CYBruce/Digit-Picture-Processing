function varargout = FDfilter(varargin)
% FDFILTER MATLAB code for FDfilter.fig
%      FDFILTER, by itself, creates a new FDFILTER or raises the existing
%      singleton*.
%
%      H = FDFILTER returns the handle to a new FDFILTER or the handle to
%      the existing singleton*.
%      FDFILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDFILTER.M with the given input arguments.
%
%      FDFILTER('Property','Value',...) creates a new FDFILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FDfilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FDfilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FDfilter

% Last Modified by GUIDE v2.5 10-Jun-2018 11:10:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FDfilter_OpeningFcn, ...
                   'gui_OutputFcn',  @FDfilter_OutputFcn, ...
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


% --- Executes just before FDfilter is made visible.
function FDfilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FDfilter (see VARARGIN)

% Choose default command line output for FDfilter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FDfilter wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global img_src1;
global S;  %存储结果
global lv; %设置选择低通
global hv; %设置选择高通
axes(handles.axes2)
imshow(img_src1)
Bmpfft = fft2(img_src1);%将原图进行二维傅里叶变换（自写函数运行过慢）
S = fftshift(Bmpfft);%将变换图像中心化
axes(handles.axes1)
imshow(log(abs(S)),[])
lv=0;
hv=0;



% --- Outputs from this function are returned to the command line.
function varargout = FDfilter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function h_filter_Callback(hObject, eventdata, handles)
% hObject    handle to h_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lv;
global hv;
lv = 0;
hv = 1;%设置高通

% --------------------------------------------------------------------
function l_filter_Callback(hObject, eventdata, handles)
% hObject    handle to l_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lv;
global hv;
lv = 1;%设置低通
hv = 0;

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
global lv;
global hv;
global ss;
if lv==0 && hv==0;
    sl = get(handles.slider1,'Value');%sl为半径缩放比例
    set(handles.edit1,'string',int2str(sl));
else
    s = S;
    sl = get(handles.slider1,'Value');%sl为半径缩放比例
    set(handles.edit1,'string',int2str(sl));
    [a,b] = size(s); %s为傅里叶变换后的频谱
    a0 = round(a/2);
    b0 = round(b/2);
    d = sl; %半径
    for i = 1:a      
        for j = 1:b      
            distance=sqrt((i-a0)^2+(j-b0)^2);
            if distance <= d
                h = lv;
            else
                h = hv;
            end;      
            s(i,j) = h*s(i,j);
        end;
    end;
    axes(handles.axes1)
    imshow(log(abs(s)),[])
    ss = uint8(real(ifft2(ifftshift(s)))); %反傅里叶变换
    axes(handles.axes2)
    imshow(ss)
end


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S;
global lv;
global hv;
global ss;
%和滑块callback基本相同
if lv==0 && hv==0;
    E = get(handles.edit1,'string');
    set(handles.slider1,'Value',str2num(E));%和滑块同步
else
    s = S;
    E = get(handles.edit1,'string');
    set(handles.slider1,'Value',str2num(E));
    [a,b] = size(s); %s为傅里叶变换后的频谱
    a0 = round(a/2);
    b0 = round(b/2);
    d = str2num(E); %半径
    for i = 1:a      
        for j = 1:b      
            distance=sqrt((i-a0)^2+(j-b0)^2);
            if distance <= d
                h = lv;
            else
                h = hv;
            end;      
            s(i,j) = h*s(i,j);
        end;
    end;
    axes(handles.axes1)
    imshow(log(abs(s)),[])
    ss = uint8(real(ifft2(ifftshift(s)))); 
    axes(handles.axes2)
    imshow(ss)
end

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ss
global img_src1
img_src1=ss
global m_handles
axes(m_handles.axes1)
imshow(ss)
close(handles.figure1)%点击确认关闭窗口并将本图片传递至主函数
