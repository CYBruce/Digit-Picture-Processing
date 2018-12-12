function varargout = nonlinear(varargin)
% NONLINEAR MATLAB code for nonlinear.fig
%      NONLINEAR, by itself, creates a new NONLINEAR or raises the existing
%      singleton*.
%
%      H = NONLINEAR returns the handle to a new NONLINEAR or the handle to
%      the existing singleton*.
%
%      NONLINEAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NONLINEAR.M with the given input arguments.
%
%      NONLINEAR('Property','Value',...) creates a new NONLINEAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nonlinear_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nonlinear_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nonlinear

% Last Modified by GUIDE v2.5 10-Jun-2018 09:44:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nonlinear_OpeningFcn, ...
                   'gui_OutputFcn',  @nonlinear_OutputFcn, ...
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


% --- Executes just before nonlinear is made visible.
function nonlinear_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nonlinear (see VARARGIN)

% Choose default command line output for nonlinear
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nonlinear wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nonlinear_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global img_src1 
axes(handles.axes1);   %坐标轴定位，初始化显示图像
imshow(img_src1);
set(handles.slider1, 'Enable', 'off')
set(handles.slider2, 'Enable', 'off')

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I
global img_src1
global m_handles
img_src1 = I
axes(m_handles.axes1)
imshow(I)
close(handles.figure1)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global tag
global c
val=get(hObject,'value');
set(handles.edit3,'string',num2str(val,'%3.0f'));
c=val;
x=0:1:255;
y=c*log(1+x);
axes(handles.axes3);
plot(x,y);
set(handles.axes3,'XLim',[0,255]);
global img_src1
global I
global r
if tag==1
    T=double(img_src1);
    I=c*log(1+T);
    I=uint8(I);
    axes(handles.axes2);
    imshow(I);
end
if tag==2
    T=double(img_src1);
    I=c*(1+T).^r;;
    I=uint8(I);
    axes(handles.axes2);
    imshow(I);
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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


% --- Executes on button press in power.
function power_Callback(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of power
global img_src1
global I
global tag

tag=2
c=41;
r=0.05
x=0:1:255;
y=c*(1+x).^r;
axes(handles.axes3);
plot(x,y);
set(handles.axes3,'XLim',[0,255]);
set(handles.log, 'Enable', 'off')
set(handles.slider1, 'Enable', 'on')
set(handles.slider2, 'Enable', 'on')
I=double(img_src1);
I=uint8(c*(2.718281+I).^r);
axes(handles.axes2);
imshow(uint8(I));

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global tag
global r
global c
val=get(hObject,'value');
val=val/200.0
set(handles.edit4,'string',num2str(val));
r=val;
x=0:1:255;
y=c*(1+x).^r;
axes(handles.axes3);
plot(x,y);
set(handles.axes3,'XLim',[0,255]);
global img_src1
global I
T=double(img_src1);
I=c*(1+T).^r;;
I=uint8(I);
axes(handles.axes2);
imshow(I);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in log.
function log_Callback(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of log
global img_src1
global I
global tag
tag=1
c=41;
x=0:1:255;
y=c*log(1+x);
axes(handles.axes3);
plot(x,y);
set(handles.axes3,'XLim',[0,255]);
set(handles.power, 'Enable', 'off')
set(handles.slider2, 'Enable', 'off')
set(handles.slider1, 'Enable', 'on')
I=double(img_src1);
I=uint8(c*log(1+I));
axes(handles.axes2);
imshow(uint8(I));


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.power, 'Enable', 'on')
set(handles.edit4, 'Enable', 'on')
set(handles.slider2, 'Enable', 'on')
set(handles.log, 'Enable', 'on')
set(handles.edit3, 'Enable', 'on')
set(handles.slider1, 'Enable', 'on')



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
