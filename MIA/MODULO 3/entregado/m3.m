function varargout = m3(varargin)
% M3 MATLAB code for m3.fig
%      M3, by itself, creates a new M3 or raises the existing
%      singleton*.
%
%      H = M3 returns the handle to a new M3 or the handle to
%      the existing singleton*.
%
%      M3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in M3.M with the given input arguments.
%
%      M3('Property','Value',...) creates a new M3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before m3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to m3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help m3

% Last Modified by GUIDE v2.5 18-Jan-2014 17:13:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @m3_OpeningFcn, ...
                   'gui_OutputFcn',  @m3_OutputFcn, ...
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


% --- Executes just before m3 is made visible.
function m3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to m3 (see VARARGIN)

% Choose default command line output for m3
handles.output = hObject;


set(handles.umbral,'String','0');
set(handles.sigma,'String','0.2');
set(handles.distancia,'String','2');
set(handles.umbralesquinas,'String','1000');
handles.maximosactivos = get(handles.ml,'Value');
handles.detectandofronteras = 0;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes m3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = m3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in abrir.
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
handles.img = imread(imgetfile());

tama = size(size(handles.img));
tam=size(handles.img);

if tama(2)==3
    handles.img = rgb2gray(handles.img);
end

imshow(handles.img);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in robertsmatlab.
function robertsmatlab_Callback(hObject, eventdata, handles)
% hObject    handle to robertsmatlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of robertsmatlab
   
set(handles.roberts,'Value',0);
set(handles.sobelmatlab,'Value',0);
set(handles.sobel,'Value',0);
set(handles.prewittmatlab,'Value',0);
set(handles.prewitt,'Value',0);
set(handles.canny,'Value',0);

% Update handles structure
guidata(hObject, handles);
    

% --- Executes on button press in roberts.
function roberts_Callback(hObject, eventdata, handles)
% hObject    handle to roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of roberts

set(handles.robertsmatlab,'Value',0);
set(handles.sobelmatlab,'Value',0);
set(handles.sobel,'Value',0);
set(handles.prewittmatlab,'Value',0);
set(handles.prewitt,'Value',0);
set(handles.canny,'Value',0);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in sobelmatlab.
function sobelmatlab_Callback(hObject, eventdata, handles)
% hObject    handle to sobelmatlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sobelmatlab
    
set(handles.robertsmatlab,'Value',0);
set(handles.sobel,'Value',0);
set(handles.roberts,'Value',0);
set(handles.prewittmatlab,'Value',0);
set(handles.prewitt,'Value',0);
set(handles.canny,'Value',0);

% Update handles structure
guidata(hObject, handles);
    

% --- Executes on button press in sobel.
function sobel_Callback(hObject, eventdata, handles)
% hObject    handle to sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sobel

set(handles.robertsmatlab,'Value',0);
set(handles.roberts,'Value',0);
set(handles.sobelmatlab,'Value',0);
set(handles.prewittmatlab,'Value',0);
set(handles.prewitt,'Value',0);
set(handles.canny,'Value',0);
    
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in prewittmatlab.
function prewittmatlab_Callback(hObject, eventdata, handles)
% hObject    handle to prewittmatlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prewittmatlab

set(handles.robertsmatlab,'Value',0);
set(handles.roberts,'Value',0);
set(handles.sobel,'Value',0);
set(handles.prewitt,'Value',0);
set(handles.sobelmatlab,'Value',0);
set(handles.canny,'Value',0);

% Update handles structure
guidata(hObject, handles);    
    

% --- Executes on button press in prewitt.
function prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prewitt

set(handles.robertsmatlab,'Value',0);
set(handles.roberts,'Value',0);
set(handles.sobel,'Value',0);
set(handles.prewittmatlab,'Value',0);
set(handles.sobelmatlab,'Value',0);
set(handles.canny,'Value',0);

% Update handles structure
guidata(hObject, handles);
    

% --- Executes on button press in canny.
function canny_Callback(hObject, eventdata, handles)
% hObject    handle to canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of canny

set(handles.robertsmatlab,'Value',0);
set(handles.roberts,'Value',0);
set(handles.sobel,'Value',0);
set(handles.prewittmatlab,'Value',0);
set(handles.prewitt,'Value',0);
set(handles.sobelmatlab,'Value',0);

% Update handles structure
guidata(hObject, handles);
    

% --- Executes on button press in detectarfronteras.
function detectarfronteras_Callback(hObject, eventdata, handles)
% hObject    handle to detectarfronteras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.detectandofronteras = 1;

img = im2double(handles.img);

if (get(handles.robertsmatlab,'Value')==1)
    
    if(strcmp(get(handles.umbral,'String'),'0')==1)
        
        axes(handles.axes2);
        [robertsmat,umbral] = edge(img,'roberts');
        set(handles.umbral,'String',num2str(umbral));
        handles.Rasgos = robertsmat;
        imshow(robertsmat);
    
    elseif(strcmp(get(handles.umbral,'String'),'0')==0)
        
        axes(handles.axes2);
        robertsmat = edge(img,'roberts',str2num(get(handles.umbral,'String')));
        handles.Rasgos = robertsmat;
        imshow(robertsmat);
        
    end
    
elseif (get(handles.roberts,'Value')==1)
    
    umb = double(str2num(get(handles.umbral,'String')));
    
    m1 = [1 0; 0 -1];
    m2 = [0 -1; 1 0];
    
    I1 = imfilter(img, m1);
    I2 = imfilter(img, m2);
    I = (I1.*I1) + (I2.*I2);
    I = double(I);
    G = sqrt(I);
  
   
    roberts = G > umb;
    handles.Rasgos = roberts;
    
    axes(handles.axes2);
    imshow(roberts);
    
   
elseif (get(handles.sobelmatlab,'Value')==1)
    
    if(strcmp(get(handles.umbral,'String'),'0')==1)
        
        axes(handles.axes2);
        [sobelmat,umbral] = edge(img,'sobel');
        set(handles.umbral,'String',num2str(umbral));
        handles.Rasgos = sobelmat;
        imshow(sobelmat);
    
    elseif(strcmp(get(handles.umbral,'String'),'0')==0)
        
        axes(handles.axes2);
        sobelmat = edge(img,'sobel',str2num(get(handles.umbral,'String')));
        handles.Rasgos = sobelmat;
        imshow(sobelmat);
        
    end
    
    
elseif (get(handles.sobel,'Value')==1)
    
    umb = str2num(get(handles.umbral,'String'));
    
    m1 = [-1 -2 -1 ; 0 0 0 ; 1 2 1];
    m2 = [-1 0 1 ; -2 0 2 ; -1 0 1];
    
    I1 = imfilter(img, m1);
    I2 = imfilter(img, m2);
    
    I = (I1.*I1) + (I2.*I2);
    I = double(I);
    G = sqrt(I);
    G =im2double(G);
    
    sobel = G > umb;
    handles.Rasgos = sobel;
    
    axes(handles.axes2);
    imshow(sobel);
    

    
elseif (get(handles.prewittmatlab,'Value')==1)
    
    if(strcmp(get(handles.umbral,'String'),'0')==1)
        axes(handles.axes2);
        [prewittmat,umbral] = edge(img,'prewitt');
        set(handles.umbral,'String',num2str(umbral));
        handles.Rasgos = prewittmat;
        imshow(prewittmat);
    
    elseif(strcmp(get(handles.umbral,'String'),'0')==0)
        
        axes(handles.axes2);
        prewittmat = edge(img,'prewitt',str2num(get(handles.umbral,'String')));
        handles.Rasgos = prewittmat;
        imshow(prewittmat);
        
    end
   
    
elseif (get(handles.prewitt,'Value')==1)
    
    umb = str2num(get(handles.umbral,'String'));
    
    m1 = [-1 -1 -1 ; 0 0 0 ; 1 1 1];
    m2 = [-1 0 1 ; -1 0 1 ; -1 0 1];
    
    I1 = imfilter(img, m1);
    I2 = imfilter(img, m2);
    
    I = (I1.*I1) + (I2.*I2);
    I = double(I);
    G = sqrt(I);
    G =im2double(G);
    
    prewitt = G > umb;
    handles.Rasgos = prewitt;
    
    axes(handles.axes2);
    imshow(prewitt);
    
  
    
elseif (get(handles.canny,'Value')==1)
    
    if(strcmp(get(handles.umbral,'String'),'0')==1)
        
        axes(handles.axes2);
        [cannymat,umbral] = edge(img,'canny');
        set(handles.umbral,'String',num2str(umbral(2)));
        handles.Rasgos = cannymat;
        imshow(cannymat);
    
    elseif(strcmp(get(handles.umbral,'String'),'0')==0)
        
        axes(handles.axes2);
        umbral1 = str2num(get(handles.umbral,'String'));
        umbral2 = umbral1 * 0.4;
        umbral = [umbral2 umbral1];
        cannymat = edge(img,'canny',umbral, str2num(get(handles.sigma,'String')));
        handles.Rasgos = cannymat;
        imshow(cannymat);
    end
    
    
    
end


% Update handles structure
guidata(hObject, handles);



function umbral_Callback(hObject, eventdata, handles)
% hObject    handle to umbral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbral as text
%        str2double(get(hObject,'String')) returns contents of umbral as a double


% --- Executes during object creation, after setting all properties.
function umbral_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in visualizar.
function visualizar_Callback(hObject, eventdata, handles)
% hObject    handle to visualizar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2);
imshow(handles.img); axis off; hold on;
[f,c] = find(handles.Rasgos);
plot(c,f,handles.color); hold off; 

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rojo.
function rojo_Callback(hObject, eventdata, handles)
% hObject    handle to rojo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.detectandofronteras == 1)
    
    handles.color = 'r.';
    
else handles.color = 'r+';
    
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in verde.
function verde_Callback(hObject, eventdata, handles)
% hObject    handle to verde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.detectandofronteras == 1)
    
    handles.color = 'g.';
    
else handles.color = 'g+';
    
end


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in amarillo.
function amarillo_Callback(hObject, eventdata, handles)
% hObject    handle to amarillo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.detectandofronteras == 1)
    
    handles.color = 'y.';
    
else handles.color = 'y+';
    
end

% Update handles structure
guidata(hObject, handles);


function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigmatxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigmatxt as text
%        str2double(get(hObject,'String')) returns contents of sigmatxt as a double


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigmatxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in detectaresquinas.
function detectaresquinas_Callback(hObject, eventdata, handles)
% hObject    handle to detectaresquinas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.detectandofronteras = 0;

I = double(handles.img);

mascara = [-1 0 1];
Ix = imfilter(I, mascara, 'replicate');
Iy = imfilter(I, mascara', 'replicate');


%obtener vecindario
if(get(handles.vecindad3,'Value') == 1)
    
    vecindad = 3;
    
end
if(get(handles.vecindad5,'Value') == 1)
    
    vecindad = 5;
    
end

%calcular el gradiente horizontal y vertical de la imagen
mascarasuma = ones(vecindad,vecindad);
Ix2 = Ix.^2;
Suma_Ix2 = imfilter(Ix2, mascarasuma,'replicate');
Iy2 = Iy.^2;
Suma_Iy2 = imfilter(Iy2, mascarasuma,'replicate');
Ixy = Ix.*Iy;
Suma_Ixy = imfilter(Ixy, mascarasuma,'replicate');

[nf, nc] = size(I);


%Calcular autovalores de la matriz obtenida en cada punto
Autovalores = zeros(nf, nc);
for i = 1:nf
    
    for j = 1:nc 
        
        C = ([Suma_Ix2(i,j) Suma_Ixy(i,j) ; Suma_Ixy(i,j) Suma_Iy2(i,j)]);   
        d = eig(C);
        Autovalores(i,j) = min(d);
        
    end;
    
end;

%Definir el umbral y marcar las esquinas (Autovalores de la matriz mayores que el umbral)
umbralEsq = str2num(get(handles.umbralesquinas,'String'));

Esquinas = Autovalores > umbralEsq;


%Suprimir los no maximos locales
if(handles.maximosactivos == 1)
    
    dis = double(str2num(get(handles.distancia,'String')));
    
    if(mod(dis,2) == 0)
        
        dis = dis+1;
        
    end
    
    %eliminar de lo que teniamos marcado como esquinas los autovalores que no son maximos locales
    maximosLocales = ordfilt2(Autovalores,dis*dis,ones(dis,dis));
    Esquinas = Esquinas .* (maximosLocales == Autovalores);

end

handles.Rasgos = Esquinas;

axes(handles.axes2);
imshow(Esquinas);
 


% Update handles structure
guidata(hObject, handles);


function umbralesquinas_Callback(hObject, eventdata, handles)
% hObject    handle to umbralesquinas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbralesquinas as text
%        str2double(get(hObject,'String')) returns contents of umbralesquinas as a double


% --- Executes during object creation, after setting all properties.
function umbralesquinas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbralesquinas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ml.
function ml_Callback(hObject, eventdata, handles)
% hObject    handle to ml (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ml
handles.maximosactivos = get(handles.ml,'Value');

% Update handles structure
guidata(hObject, handles);



function distancia_Callback(hObject, eventdata, handles)
% hObject    handle to distancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distancia as text
%        str2double(get(hObject,'String')) returns contents of distancia as a double


% --- Executes during object creation, after setting all properties.
function distancia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in vecindad3.
function vecindad3_Callback(hObject, eventdata, handles)
% hObject    handle to vecindad3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vecindad3

set (handles.vecindad5,'Value',0);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in vecindad5.
function vecindad5_Callback(hObject, eventdata, handles)
% hObject    handle to vecindad5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vecindad5

set (handles.vecindad3,'Value',0);

% Update handles structure
guidata(hObject, handles);
