function varargout = binary_shape(varargin)
% BINARY_SHAPE MATLAB code for binary_shape.fig
%      BINARY_SHAPE, by itself, creates a new BINARY_SHAPE or raises the existing
%      singleton*.
%
%      H = BINARY_SHAPE returns the handle to a new BINARY_SHAPE or the handle to
%      the existing singleton*.
%
%      BINARY_SHAPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BINARY_SHAPE.M with the given input arguments.
%
%      BINARY_SHAPE('Property','Value',...) creates a new BINARY_SHAPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before binary_shape_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to binary_shape_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help binary_shape

% Last Modified by GUIDE v2.5 09-Jun-2018 12:49:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @binary_shape_OpeningFcn, ...
                   'gui_OutputFcn',  @binary_shape_OutputFcn, ...
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


% --- Executes just before binary_shape is made visible.
function binary_shape_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to binary_shape (see VARARGIN)

% Choose default command line output for binary_shape
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes binary_shape wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = binary_shape_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in square.
function square_Callback(hObject, eventdata, handles)
% hObject    handle to square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shape %定义形状
global shape_size  %定义形状大小
a=shape_size

shape=strel('square',double(a))
axes(handles.axes_shape); %模板展示
imshow([0,0,0,0,0,0,0;
    0,1,1,1,1,1,0;    
    0,1,1,1,1,1,0;
    0,1,1,1,1,1,0;
    0,1,1,1,1,1,0;
    0,1,1,1,1,1,0;
    0,0,0,0,0,0,0]);

% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw
global shape
bw=imopen(bw,shape)
axes(handles.binary_axes);
imshow(bw)

% --- Executes on button press in errosion.
function errosion_Callback(hObject, eventdata, handles)
% hObject    handle to errosion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw
global shape
bw=imerode(bw,shape)
axes(handles.binary_axes);
imshow(bw)

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw
global shape
bw=imclose(bw,shape)
axes(handles.binary_axes);
imshow(bw)

% --- Executes on button press in circle.
function circle_Callback(hObject, eventdata, handles)
% hObject    handle to circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shape
global shape_size
a=shape_size
shape=strel('disk',double(a))
axes(handles.axes_shape);
imshow([0,0,0,0,1,1,1,0,0,0,0;
    0,0,1,1,1,1,1,1,1,0,0;    
    0,1,1,1,1,1,1,1,1,1,0;
    0,1,1,1,1,1,1,1,1,1,0;
    0,1,1,1,1,1,1,1,1,1,0;
    1,1,1,1,1,1,1,1,1,1,1;
    1,1,1,1,1,1,1,1,1,1,1;
    0,1,1,1,1,1,1,1,1,1,0;
    0,1,1,1,1,1,1,1,1,1,0;
    0,0,1,1,1,1,1,1,1,0,0;
    0,0,0,0,1,1,1,0,0,0,0]);

% --- Executes on button press in diamond.
function diamond_Callback(hObject, eventdata, handles)
% hObject    handle to diamond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shape
global shape_size
a=shape_size
shape=strel('diamond',double(a))
axes(handles.axes_shape);
imshow([0,0,0,0,0,1,0,0,0,0,0;
    0,0,0,0,1,1,1,0,0,0,0;    
    0,0,0,1,1,1,1,1,0,0,0;
    0,0,1,1,1,1,1,1,1,0,0;
    0,1,1,1,1,1,1,1,1,1,0;
    1,1,1,1,1,1,1,1,1,1,1;
    0,1,1,1,1,1,1,1,1,1,0;
    0,0,1,1,1,1,1,1,1,0,0;
    0,0,0,1,1,1,1,1,0,0,0;
    0,0,0,0,1,1,1,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0,0]);

% --- Executes on button press in expansion.
function expansion_Callback(hObject, eventdata, handles)
% hObject    handle to expansion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bw
global shape
bw=imdilate(bw,shape)
axes(handles.binary_axes);
imshow(bw)


% --- Executes on slider movement.
function size_bar_Callback(hObject, eventdata, handles)
% hObject    handle to size_bar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global shape_size
shape_size = 3+uint8(17*get(hObject,'Value')); %滑块值设置
set(handles.text5,'String',num2str(shape_size));

% --- Executes during object creation, after setting all properties.
function size_bar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_bar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
global bw
img_src1=255*bw
global m_handles
axes(m_handles.axes1)
imshow(bw,[])
in_stack()
close(handles.figure1)  %点击确认关闭窗口并把图片转移到主窗口
