    function varargout = braille(varargin)
% BRAILLE MATLAB code for braille.fig
%      BRAILLE, by itself, creates a new BRAILLE or raises the existing
%      singleton*.
%
%      H = BRAILLE returns the handle to a new BRAILLE or the handle to
%      the existing singleton*.
%
%      BRAILLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAILLE.M with the given input arguments.
%
%      BRAILLE('Property','Value',...) creates a new BRAILLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before braille_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to braille_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help braille

% Last Modified by GUIDE v2.5 26-Jan-2021 13:14:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @braille_OpeningFcn, ...
                   'gui_OutputFcn',  @braille_OutputFcn, ...
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
%addpath(genpath('./braille-utils/text2braille-src/'));
% End initialization code - DO NOT EDIT


% --- Executes just before braille is made visible.
function braille_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to braille (see VARARGIN)

% Choose default command line output for braille
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

movegui(gcf,'center');
logo = imread('uni.jpg');
set(handles.axes1, 'XTick', []); set(handles.axes3, 'YTick', []);
axes(handles.axes3);
Y = imresize(logo,[110 100],'bilinear');
imshow(Y);

global myImage;
myImage = [];
set(handles.axes1,'YTick',[]);
set(handles.axes1,'XTick',[]);
set(handles.axes2,'YTick',[]);
set(handles.axes2,'XTick',[]);

% UIWAIT makes braille wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = braille_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global n_path1;

name = mfilename;
path = mfilename('fullpath');
n_path1 = path(1:end-length(name)-1);



% --- Executes on button press in cargar.
function cargar_Callback(hObject, eventdata, handles)
% hObject    handle to cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Select image files only!');
global myImage;
myImage = imread(fullfile(PathName,FileName));
axes(handles.axes1);
set(handles.text2, 'String', FileName);
imshow(myImage);
set(handles.traducir,'Enable','on');



% --- Executes on button press in traducir.
function traducir_Callback(hObject, eventdata, handles)
% hObject    handle to traducir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myImage;
global myImageBraille;
global texto;

myImage = im2bw(myImage);
%%%
wait = waitbar(0,'Traduccion en curso');


[myImageBraille,texto]=imagenabraille(myImage,wait);
axes(handles.axes2);
imshow(myImageBraille);

set(handles.traducir,'Enable','off');
set(handles.guardar,'Enable','on');
set(handles.guardartxt,'Enable','on');
set(handles.text2, 'String', texto);


% --- Executes on button press in guardar.
function guardar_Callback(hObject, eventdata, handles)
% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myImageBraille n_path1;

% Directorio predefinido
[filename, pathname] = uiputfile({'*.jpg';'*.tif';'*.png'},'Guardar IMAGEN',[n_path1, '\Imagenes Guardadas']');
if isequal(filename,0)
else
    imwrite(myImageBraille,fullfile(pathname, filename));
end




% --- Executes on button press in guardartxt.
function guardartxt_Callback(hObject, eventdata, handles)
% hObject    handle to guardartxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global texto n_path1;
[fileName,pathName]=uiputfile('braille.txt','Guardar Texto',[n_path1, '\Textos Guardados']);
archivotxt = fopen(fullfile(pathName,fileName), 'wt');
fprintf(archivotxt,'%s\n',texto{:});
fclose(archivotxt);



% --- Executes on button press in salir.
function salir_Callback(hObject, eventdata, handles)
% hObject    handle to salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all
close all

% --- Executes on button press in limpiar.
function limpiar_Callback(hObject, eventdata, handles)
% hObject    handle to limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset')
set(handles.axes1, 'XTick', []); set(handles.axes1, 'YTick', []);
cla(handles.axes2,'reset')
set(handles.axes2, 'XTick', []); set(handles.axes2, 'YTick', []);

set(handles.cargar,'enable','on')
set(handles.traducir,'enable','off')
set(handles.guardar,'enable','off')
set(handles.guardartxt,'enable','off')
set(handles.limpiar,'enable','on')
set(handles.salir,'enable','on')
