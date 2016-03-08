function varargout = MRERECONSTRUCT(varargin)
% CAT_MRI_AXES2 M-file for CAT_MRI_AXES2.fig
%      CAT_MRI_AXES2, by itself, creates a new CAT_MRI_AXES2 or raises the existing
%      singleton*.
%
%      H = CAT_MRI_AXES2 returns the handle to a new CAT_MRI_AXES2 or the handle to
%      the existing singleton*.
%
%      CAT_MRI_AXES2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAT_MRI_AXES2.M with the given input arguments.
%
%      CAT_MRI_AXES2('Property','Value',...) creates a new CAT_MRI_AXES2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CAT_MRI_AXES2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CAT_MRI_AXES2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CAT_MRI_AXES2

% Last Modified by GUIDE v2.5 13-Dec-2007 09:53:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MRERECONSTRUCT_OpeningFcn, ...
    'gui_OutputFcn',  @MRERECONSTRUCT_OutputFcn, ...
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


% --- Executes just before CAT_MRI_AXES2 is made visible.
function MRERECONSTRUCT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CAT_MRI_AXES2 (see VARARGIN)

% Choose default command line output for CAT_MRI_AXES2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CAT_MRI_AXES2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MRERECONSTRUCT_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in forward.
function forward_Callback(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.image < handles.size(3)
    handles.image = handles.image + 1;
    set(handles.edit,'string',[num2str(handles.image),'/',num2str(handles.size(3))]);
    axes(handles.axes);
    imagesc(handles.MagIm(:,:,handles.image),[0 handles.max]),colormap(bone);
    axes(handles.axes2);
    imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);
    guidata(hObject,handles);   
end

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name='Mask.mat';
handles.maskorig=handles.mask;
mask=handles.mask(:,:,:,1);
save([handles.PARPATH,name],'mask');
delete 'lastUsedDir.mat'
guidata(hObject,handles);


%Resizes mask if using high res (256x256) MRI image
function masko=resizemask(maskin,handles,currentslice)

for i=1:64
for j=1:64
masko(i,j,currentslice)=mean2(maskin((4*i-3):4*i,(4*j-3):4*j));
if masko(i,j,currentslice)<.5
masko(i,j,currentslice)=0;
else
masko(i,j,currentslice)=1;
end
end
end

% --- Executes on button press in sel_reg.
function sel_reg_Callback(hObject, eventdata, handles)
% hObject    handle to sel_reg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes);
imagesc(handles.MagIm(:,:,handles.image),[0 handles.max]),colormap(bone);
handles.sel=roipoly;
if size(handles.sel,1)~=size(handles.MagImSmall,1)
    if size(handles.sel,1)==size(handles.MagImSmall,1)*4
    maskslic=resizemask(handles.sel,handles,handles.image);
    handles.mask(:,:,handles.image)=maskslic(:,:,handles.image);
        else
        errordlg('High Res Image must be 4 times resolution of MRE')
    end
else
handles.mask(:,:,handles.image)=handles.sel;
end
handles.overlay(:,:,handles.image)=handles.mask(:,:,handles.image).*handles.MagImSmall(:,:,handles.image);
clear handles.sel;
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);
guidata(hObject,handles);

% --- Executes on button press in sub_ven.
function sub_ven_Callback(hObject, eventdata, handles)
% hObject    handle to sub_ven (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
handles.sub=roipoly;
if size(handles.sub,1)~=size(handles.MagImSmall,1)
    if size(handles.sub,1)==size(handles.MagImSmall,1)*4
    subslice=resizemask(handles.sub,handles,handles.image);
    else
        errordlg('High Res Image must be 4 times resolution of MRE')
    end
else
    subslice(:,:,handles.image)=handles.sub;
end
handles.mask(:,:,handles.image)=handles.mask(:,:,handles.image)-handles.mask(:,:,handles.image).*subslice(:,:,handles.image);
clear handles.sub;
clear subslice;
handles.overlay(:,:,handles.image)=handles.mask(:,:,handles.image).*handles.MagImSmall(:,:,handles.image);
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);
guidata(hObject,handles);

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.image > 1
    handles.image = handles.image - 1;
    set(handles.edit,'string',[num2str(handles.image),'/',num2str(handles.size(3))]);
    axes(handles.axes);
    imagesc(handles.MagIm(:,:,handles.image),[0 handles.max]),colormap(bone);
    axes(handles.axes2);
    imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);
    guidata(hObject,handles);   
end

% --- Executes on button press in load_mask.
function load_mask_Callback(hObject, eventdata, handles)
% hObject    handle to load_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.filename2,handles.pathname2] = uigetfile2('*.mat','Choose an existing mask');
handles.eximask = load([handles.pathname2,handles.filename2]);
if size(handles.eximask.mask)==handles.size
handles.mask= handles.eximask.mask;
handles.maskorig=handles.mask;
handles.overlay=handles.mask.*handles.MagImSmall;
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);
end
guidata(hObject,handles);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.overlay(:,:,handles.image)=handles.maskorig(:,:,handles.image).*handles.MagImSmall(:,:,handles.image);
handles.mask(:,:,handles.image)=handles.maskorig(:,:,handles.image);
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);
guidata(hObject,handles);

% --- Executes on button press in selectm.
function selectm_Callback(hObject, eventdata, handles)
% hObject    handle to selectm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.PARMFILE,handles.PARPATH] = uigetfile2('*.PAR','Par Files (*.PAR)','Choose a PAR File');
set (handles.mfile,'String',[handles.PARPATH,handles.PARMFILE]);
guidata(hObject,handles);

% --- Executes on button press in pushbutton12.
function selectp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.PARPFILE,handles.PARPATH] = uigetfile2('*.PAR','Par Files (*.PAR)','Choose a PAR File');
set (handles.pfile,'String',[handles.PARPATH,handles.PARPFILE]);
guidata(hObject,handles);

% --- Executes on button press in selects.
function selects_Callback(hObject, eventdata, handles)
% hObject    handle to selects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.PARSFILE,handles.PARPATH] = uigetfile2('*.PAR','Par Files (*.PAR)','Choose a PAR File');
set (handles.sfile,'String',[handles.PARPATH,handles.PARSFILE]);
guidata(hObject,handles);


% --- Executes on button press in sendtounwrap.
function sendtounwrap_Callback(hObject, eventdata, handles)
% hObject    handle to sendtounwrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'SendData',handles);
MREMotion(handles)
guidata(hObject,handles);


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
MAX = max(max(handles.MagIm(:,:,handles.image)));

handles.level = get(handles.slider,'value')*MAX;
axes(handles.axes);
imagesc(handles.MagIm(:,:,handles.image),[0 handles.max]),colormap(bone);
hold on;
[c,h]=contour(handles.MagIm(:,:,handles.image),[handles.level handles.level],'r','linewidth',2); axis image;
hold off;
handles.d = 1;
handles.flag = 0;
set(handles.dist,'string',num2str(handles.d));
handles.h = h;
len = -1; k=0;
h = get(h,'children');
% find the longest contour
for j=1:length(h)
    x=get(h(j),'xdata');
    if length(x)>len
        len=length(x);
        k=j;
    end
end
x=get(h(k),'xdata'); x=x(~isnan(x));
y=get(h(k),'ydata'); y=y(~isnan(y));

clear c;
c(1,:) = x';
c(2,:) = y';

handles.c = c;
handles.flag = 0;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.flag == 0
len = -1; k=0;
h = get(handles.h,'children');

% find the longest contour
for j=1:length(h)
    x=get(h(j),'xdata');
    if length(x)>len
        len=length(x);
        k=j;
    end
end
x=get(h(k),'xdata'); x=x(~isnan(x));
y=get(h(k),'ydata'); y=y(~isnan(y));
else
    c = handles.c';
    x = c(:,1);
    y = c(:,2);
end

xmin=floor(min(x));xmax=ceil(max(x));
ymin=floor(min(y));ymax=ceil(max(y));
[XX,YY]=meshgrid(xmin:xmax,ymin:ymax);
XX=XX(:);YY=YY(:);
% when im size is 512*512, inpolygon becomes bottleneck.  Maybe we can
% downsample the im (e.g., 256*256).  Or change inpolygon file to allow
% a bigger chunk of memory allocation.
IN = inpolygon(XX,YY,x,y);
I=find(IN>0);
bw=zeros(size(handles.MagIm(:,:,handles.image)));
XX=XX(I);YY=YY(I);
for j=1:length(YY);
    bw(YY(j),XX(j))=1;
end
if size(bw,1)~=size(handles.MagImSmall,1)
    if size(bw,1)==size(handles.MagImSmall,1)*4
    masklarge=bw;
    maskslice=resizemask(masklarge,handles,handles.image);
    handles.mask(:,:,handles.image)=maskslice(:,:,handles.image);
    else
    errordlg('High Res Image must be 4 times resolution of MRE')
    end
else
handles.mask(:,:,handles.image)=bw;
end
handles.overlay(:,:,handles.image)=handles.mask(:,:,handles.image).*handles.MagImSmall(:,:,handles.image);
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function mfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes during object creation, after setting all properties.
function sfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [filename, pathname, filterindex] = uigetfile2(varargin)

%UIGETFILE2 Standard open file dialog box which remembers last opened folder
%   UIGETFILE2 is a wrapper for Matlab's UIGETFILE function which adds the
%   ability to remember the last folder opened.  UIGETFILE2 stores
%   information about the last folder opened in a mat file which it looks
%   for when called.
%
%   UIGETFILE2 can only remember the folder used if the current directory
%   is writable so that a mat file can be stored.  Only successful file
%   selections update the folder remembered.  If the user cancels the file
%   dialog box then the remembered path is left the same.
%
%   Usage is the same as UIGETFILE.
%
%
%   See also UIGETFILE, UIPUTFILE, UIGETDIR.

%   Written by Chris J Cannell and Aditya Gadre
%   Contact ccannell@mindspring.com for questions or comments.
%   12/05/2005

% name of mat file to save last used directory information
lastDirMat = 'lastUsedDir.mat';

% save the present working directory
savePath = pwd;
% set default dialog open directory to the present working directory
lastDir = savePath;
% load last data directory
if exist(lastDirMat, 'file') ~= 0
    % lastDirMat mat file exists, load it
    load('-mat', lastDirMat)
    % check if lastDataDir variable exists and contains a valid path
    if (exist('lastUsedDir', 'var') == 1) && ...
            (exist(lastUsedDir, 'dir') == 7)
        % set default dialog open directory
        lastDir = lastUsedDir;
    end
end

% load folder to open dialog box in
cd(lastDir);
% call uigetfile with arguments passed from uigetfile2 function
[filename, pathname, filterindex] = uigetfile(varargin{:});
% change path back to original working folder
cd(savePath);

% if the user did not cancel the file dialog then update lastDirMat mat
% file with the folder used
if ~isequal(filename,0) && ~isequal(pathname,0)
    try
        % save last folder used to lastDirMat mat file
        lastUsedDir = pathname;
        save(lastDirMat, 'lastUsedDir');
    catch
        % error saving lastDirMat mat file, display warning, the folder
        % will not be remembered
        disp(['Warning: Could not save file ''', lastDirMat, '''']);
    end
end


% --- Executes on button press in quickunwrap.
function quickunwrap_Callback(hObject, eventdata, handles)
% hObject    handle to quickunwrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MREMotionScript([handles.PARPATH,handles.PARMFILE],[handles.PARPATH,handles.PARPFILE],[handles.PARPATH,handles.PARSFILE],2,[handles.PARPATH,'Mask.mat'])


% --------------------------------------------------------------------
function DYNAMICS_Callback(hObject, eventdata, handles)
% hObject    handle to DYNAMICS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'DynaData',handles);
View_Dynamics(handles)
guidata(hObject,handles);


% --- Executes on button press in selectmri.
function selectmri_Callback(hObject, eventdata, handles)
% hObject    handle to selectmri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.MRIFILE,handles.PARPATH] = uigetfile2({'*.PAR','Par Files (*.PAR)';'*.mat','Mat Files (*.mat)'},['Choose an image stack']);
set (handles.mrifile,'String',[handles.PARPATH,handles.MRIFILE]);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function mrifile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mrifile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadall.
function loadall_Callback(hObject, eventdata, handles)
% hObject    handle to loadall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.mfile,'string'))
    errordlg('Define All Par Files')
elseif isempty(get(handles.pfile,'string'))
    errordlg('Define All Par Files')
elseif isempty(get(handles.sfile,'string'))
    errordlg('Define All Par Files')
else
[a,b,c]=imgRecon_parrec([handles.PARPATH,handles.PARMFILE]);
handles.MagIm(:,:,:,1) = mean(a(:,:,:,1,1,1,:),7);
[a,b,c]=imgRecon_parrec([handles.PARPATH,handles.PARPFILE]);
handles.MagIm(:,:,:,2) = mean(a(:,:,:,1,1,1,:),7);
[a,b,c]=imgRecon_parrec([handles.PARPATH,handles.PARSFILE]);
handles.MagIm(:,:,:,3) = mean(a(:,:,:,1,1,1,:),7);
handles.MagImSmall=mean(handles.MagIm,4);
end
handles=load_images(handles);
guidata(hObject,handles);

%Loads image data
function handles = load_images(handles)

handles.magsmamax=max(max(max(max(handles.MagImSmall))));
handles.magsmamin=min(min(min(min(handles.MagImSmall))));
handles.size = size(handles.MagImSmall);
if isempty(get(handles.mrifile,'string'))
    handles.MagIm=handles.MagImSmall;
elseif handles.MRIFILE(length(handles.MRIFILE)-2:length(handles.MRIFILE))=='mat'
handles.MRI = load([handles.PARPATH,handles.MRIFILE]);
handles.MagIm = double(handles.MRI.MRI);
elseif handles.MRIFILE(length(handles.MRIFILE)-2:length(handles.MRIFILE))=='PAR'
[handles.mridata,b,c]=imgRecon_parrec([handles.PARPATH,handles.MRIFILE]);
handles.MagIm=handles.mridata;
end
handles.image = 1;
handles.max=max(max(max(max(handles.MagIm))));

set(handles.edit,'string',[num2str(handles.image),'/',num2str(handles.size(3))]);
handles.overlay=zeros(handles.size);
handles.maskorig=zeros(handles.size);
handles.mask=zeros(handles.size);
axes(handles.axes);
imagesc(handles.MagIm(:,:,handles.image),[0 handles.max]),colormap(bone);
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[0 handles.max]);
MAX = max(max(handles.MagIm(:,:,handles.image)));
MIN = min(min(handles.MagIm(:,:,handles.image)));
step = (1-MIN/MAX)/50;
set(handles.slider,'sliderstep',[step step*5],'max',MAX/MAX,'min',MIN/MAX,'value',0.5*MAX/MAX);
handles.level = 0.5*MAX;



% --------------------------------------------------------------------
function instructions_Callback(hObject, eventdata, handles)
% hObject    handle to instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpstring={ ...
'1. Select M, P, and S files (256x256 MRI if availiable)'; ...
'2."Load Par,MRI Files"'; ...
'3. Create mask (contour or manually)'; ...
'       Contour - adjust slider, "Enter" to save largest contour'; ...
'       Manual - "Select Region" use left click to define region,'; ...
'              right click closes loop'; ...
'       Likewise you can "Subtract Region"'; ...
'       Move through slices with "Slice Back", "Slice Forward"'; ...
'       To redo the mask for a particular slice just repeat as above.'; ...
'4. "Save Mask", then "UNWRAP" which opens MREMotion.'; ...
'       In new window select unwrapping parameters.'; ...
'       For Unwrapping with default parameters "Quick Unwrap"'; ...
' '; ...
'"View Dynamics" can be used before mask is created'; ...
'"Post Unwrap Dynamics" requires that you save the raw data when unwrapping'; ...
};
msgbox(helpstring,'Instructions')


% --------------------------------------------------------------------
function pud_Callback(hObject, eventdata, handles)
% hObject    handle to pud2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'DynaData',handles);
Dynamics_Post_Unwrap(handles)
guidata(hObject,handles);


% --------------------------------------------------------------------
function mask3d_Callback(hObject, eventdata, handles)
% hObject    handle to mask3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.filename3,handles.pathname3] = uigetfile('*.mat','Choose a MRE 3D Motion data set');
handles.motiondata = load([handles.pathname3,handles.filename3]);
handles.MagImSmall=handles.motiondata.MagIm;
handles=load_images(handles);
handles.PARPATH=handles.pathname3;
guidata(hObject,handles);

% --------------------------------------------------------------------
function createmask_Callback(hObject, eventdata, handles)
% hObject    handle to createmask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for ii=1:size(handles.MagImSmall,3)
ind=find(handles.motiondata.A(:,:,ii));
zeroma=zeros(size(handles.MagImSmall,1),size(handles.MagImSmall,2));
zeroma(ind)=1;
zeromask(:,:,ii)=zeroma;
end

handles.mask=zeromask;
handles.maskorig=handles.mask;
handles.overlay=handles.mask.*handles.MagImSmall;
axes(handles.axes2);
imagesc(handles.overlay(:,:,handles.image),[handles.magsmamin handles.magsmamax]);

guidata(hObject,handles);


% --------------------------------------------------------------------
function repmask_Callback(hObject, eventdata, handles)
% hObject    handle to repmask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
singleslice=handles.mask(:,:,handles.image);
handles.mask=repmat(singleslice,[1 1 size(handles.MagImSmall,3)]);
handles.overlay=handles.mask.*handles.MagImSmall;
guidata(hObject,handles);


% --- Executes on button press in shrink.
function shrink_Callback(hObject, eventdata, handles)
% hObject    handle to shrink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
co = handles.c;
d = handles.d;

% find the longest contour
%for j=1:length(h)
%    x=get(h(j),'xdata');
%    if length(x)>len
%        len=length(x);
%        k=j;
%    end
%end
%x=get(h(k),'xdata'); x=x(~isnan(x));
%y=get(h(k),'ydata'); y=y(~isnan(y));
[c]=contour_centroid(co',d);
hold on;
ax = gca;
info = get(ax,'children');
%SIZE = size(info);
%if SIZE(1) == 3
    cla(info(2));
%end
plot(c(:,1),c(:,2),'b','linewidth',2);
hold off;

handles.flag = 1;
handles.c = c';
guidata(hObject,handles);


function dist_Callback(hObject, eventdata, handles)
% hObject    handle to dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dist as text
%        str2double(get(hObject,'String')) returns contents of dist as a double
d = str2double(get(hObject,'String'));
handles.d = d;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function dist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


