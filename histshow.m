function varargout = histshow(varargin)
% HISTSHOW MATLAB code for histshow.fig
%      HISTSHOW, by itself, creates a new HISTSHOW or raises the existing
%      singleton*.
%
%      H = HISTSHOW returns the handle to a new HISTSHOW or the handle to
%      the existing singleton*.
%
%      HISTSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTSHOW.M with the given input arguments.
%
%      HISTSHOW('Property','Value',...) creates a new HISTSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before histshow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to histshow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help histshow

% Last Modified by GUIDE v2.5 06-Jun-2018 15:10:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @histshow_OpeningFcn, ...
                   'gui_OutputFcn',  @histshow_OutputFcn, ...
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


% --- Executes just before histshow is made visible.
function histshow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to histshow (see VARARGIN)

% Choose default command line output for histshow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global img_src1
axes(handles.axes1);%确定要操作的坐标轴
imshow(img_src1);
axes(handles.axes3)
imhist(img_src1)
temp=myhistequ(img_src1)
axes(handles.axes2);%确定要操作的坐标轴
imshow(temp);
axes(handles.axes4)
imhist(temp)
% UIWAIT makes histshow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = histshow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src1
img_src1=myhistequ(img_src1)  %myhistequ是自写函数
global m_handles
axes(m_handles.axes1)
in_stack()
imshow(img_src1);
close(handles.figure1)
