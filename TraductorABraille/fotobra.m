    function varargout = fotobra(varargin)
% FOTOBRA MATLAB code for fotobra.fig
%      FOTOBRA, by itself, creates a new FOTOBRA or raises the existing
%      singleton*.
%
%      H = FOTOBRA returns the handle to a new FOTOBRA or the handle to
%      the existing singleton*.
%
%      FOTOBRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOTOBRA.M with the given input arguments.
%
%      FOTOBRA('Property','Value',...) creates a new FOTOBRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fotobra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fotobra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fotobra

% Last Modified by GUIDE v2.5 26-Jan-2021 14:12:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fotobra_OpeningFcn, ...
                   'gui_OutputFcn',  @fotobra_OutputFcn, ...
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
%addpath(genpath('./fotobra-utils/text2braille-src/'));
% End initialization code - DO NOT EDIT


% --- Executes just before fotobra is made visible.
function fotobra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fotobra (see VARARGIN)

% Choose default command line output for fotobra
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);
set(handles.foto,'enable','on');
set(handles.guardar,'enable','off');
set(handles.guardartxt,'enable','off');
set(handles.traducir,'enable','off');
set(handles.limpiar,'enable','on');
set(handles.salir,'enable','off');

global n_path1;

name = mfilename;
path = mfilename('fullpath');
n_path1 = path(1:end-length(name)-1);


movegui(gcf,'center');
set(handles.axes1, 'XTick', []); set(handles.axes1, 'YTick', []);
set(handles.axes2, 'XTick', []); set(handles.axes2, 'YTick', []);

movegui(gcf,'center');
logo = imread('uni.jpg');
set(handles.axes3, 'XTick', []); set(handles.axes3, 'YTick', []);
axes(handles.axes3);
Y = imresize(logo,[110 100],'bilinear');
imshow(Y);



% UIWAIT makes fotobra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fotobra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure



varargout{1} = handles.output;
 
set(handles.foto,'enable','on');
set(handles.foto,'enable','on');
set(handles.traducir,'enable','off');
set(handles.guardar,'enable','off');
set(handles.guardartxt,'enable','off');
set(handles.limpiar,'enable','on');
set(handles.salir,'enable','on');


set(handles.axes1, 'XTick', []); set(handles.axes1, 'YTick', []);
set(handles.axes2, 'XTick', []); set(handles.axes2, 'YTick', []);

global camara;

hold on
axes(handles.axes1);  
camara = videoinput('winvideo',1,'MJPG_1280x720')
%camara = webcam;

global flag myImage;
flag = true;

while flag
    myImage = getsnapshot(camara);
    
    %image(myImage);
    imshow(myImage)
    fprintf('foto \n');
    %flag = false;
end
%cla(handles.axes1,'reset');
%set(handles.axes1, 'XTick', []); set(handles.axes1, 'YTick', []);
fprintf('acabamos');
hold off





% --- Executes on button press in foto.
function foto_Callback(hObject, eventdata, handles)
% hObject    handle to foto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global flag 
flag = false;

set(handles.foto,'enable','off');
set(handles.guardar,'enable','off');
set(handles.guardartxt,'enable','off');
set(handles.traducir,'enable','on');
set(handles.limpiar,'enable','on');
set(handles.salir,'enable','on');

% --- Executes on button press in traducir.
function traducir_Callback(hObject, eventdata, handles)
% hObject    handle to traducir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myImage;
global myImageBraille;
global texto;

%myImage1 = im2gray(myImage);
myImage2 = im2bw(myImage);

myImage = imresize(myImage2,1.1);
%myImage = myImage(80:1080,20:700,:) 

hold on
axes(handles.axes1); 
imshow(myImage)
hold off
%%%
wait = waitbar(0,'Traduccion en curso');

InterfaceObj=findobj(handles.figure1,'Enable','on');
set(InterfaceObj,'Enable','off');
[myImageBraille,texto]=imagenabraille(myImage,wait);
axes(handles.axes2);
imshow(myImageBraille);

set(InterfaceObj,'Enable','on');
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
[filename, pathname] = uiputfile({'*.jpg';'*.tif';'*.png'},'Guardar myImage',[n_path1, '\myImagees Guardadas']');
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

set(handles.foto,'enable','on')
set(handles.traducir,'enable','off')
set(handles.guardar,'enable','off')
set(handles.guardartxt,'enable','off')
set(handles.limpiar,'enable','off')
set(handles.salir,'enable','on')

global camara

hold on
axes(handles.axes1);  
%camara = videoinput('winvideo',1,'MJPG_1280x720')
camara = webcam

global flag myImage;
flag = true;

while flag
    myImage = snapshot(camara);
    
    %myImage = image(myImage);
    imshow(myImage)
    fprintf('foto \n');
end
fprintf('acabamos');
hold off


% --- Executes on button press in inicio.
function inicio_Callback(hObject, eventdata, handles)
% hObject    handle to inicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camara

hold on
axes(handles.axes1);  
%camara = videoinput('winvideo',1,'MJPG_1280x720')
camara = webcam

global flag myImage;
flag = true;

while flag
    myImage = snapshot(camara);
    
    %myImage = image(myImage);
    imshow(myImage)
    fprintf('foto \n');
end
fprintf('acabamos');
hold off
