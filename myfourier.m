function varargout = myfourier(varargin)
% MYFOURIER MATLAB code for myfourier.fig
%      MYFOURIER, by itself, creates a new MYFOURIER or raises the existing
%      singleton*.
%
%      H = MYFOURIER returns the handle to a new MYFOURIER or the handle to
%      the existing singleton*.
%
%      MYFOURIER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYFOURIER.M with the given input arguments.
%
%      MYFOURIER('Property','Value',...) creates a new MYFOURIER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myfourier_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myfourier_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myfourier

% Last Modified by GUIDE v2.5 21-Apr-2018 14:38:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myfourier_OpeningFcn, ...
                   'gui_OutputFcn',  @myfourier_OutputFcn, ...
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


% --- Executes just before myfourier is made visible.
function myfourier_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myfourier (see VARARGIN)

% Choose default command line output for myfourier
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myfourier wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global Bmpin;
[M,N] = size(Bmpin);
F = zeros(M,N);
Wh = zeros(M,1);      
Wl = zeros(1,N);
WH = exp(-1i * 2 * pi/M); 
WL = exp(-1i * 2 * pi/N);
for x = 1:1:M                %预计算关于行的参数Wm的列向量
    Wh(x,1)=WH^x;
end
for y = 1:1:N                %预计算关于行的参数Wn的行向量
    Wl(1,y)=WL^y;
end

for u = 1:1:M               %二维傅里叶变换
    for v = 1:1:N
        fz = zeros(M,N);
        fz = Wh.^u * Wl.^v .* double(Bmpin);
        F(u,v) = sum(sum(fz));
    end
end

FS = fftshift(F);%将变换图像中心化
axes(handles.axes1)
A = log(abs(FS));%绘制频谱图
imshow(A,[])

axes(handles.axes2)
B = (angle(FS)*180/pi);%绘制相谱图
imshow(B,[])
                



% --- Outputs from this function are returned to the command line.
function varargout = myfourier_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
