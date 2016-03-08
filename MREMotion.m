function varargout = MREMotion(varargin)
% MREMOTION M-file for MREMotion.fig
%==========================================================================
% Created by    Huifang Wang, PhD Candidate
%               Thayer School of Engineering, Dartmouth College
%               Date: 11/20/2006
%==========================================================================


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MREMotion_OpeningFcn, ...
                   'gui_OutputFcn',  @MREMotion_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MREMotion is made visible.
function MREMotion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MREMotion (see VARARGIN)

% Choose default command line output for MREMotion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MREMotion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MREMotion_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Par/Rec info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes during object creation, after setting all properties.
function parreceditM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parreceditM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function parreceditM_Callback(hObject, eventdata, handles)
% hObject    handle to parreceditM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parreceditM as text
%        str2double(get(hObject,'String')) returns contents of parreceditM as a double


% --- Executes on button press in parrecbuttonM.
function parrecbuttonM_Callback(hObject, eventdata, handles)
% hObject    handle to parrecbuttonM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% [filename, pathname] = uigetfile({'*.PAR','Par Files (*.PAR)';'*.REC','Rec Files (*.REC)'; ...
%         '*.*','All Files (*.*)'}, 'Select a Par file');
% if filename == 0
%     return
% else
%     set(handles.parreceditM,'String',[pathname,filename])
% end

[handles.PARMFILE,handles.PARPATH] = uigetfile2({'*.PAR','Par Files (*.PAR)';'*.REC','Rec Files (*.REC)'; ...
        '*.*','All Files (*.*)'}, 'Select a Par file');
if handles.PARMFILE == 0
    return
else
    set(handles.parreceditM,'String',[handles.PARPATH,handles.PARMFILE])
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function parreceditP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parreceditP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function parreceditP_Callback(hObject, eventdata, handles)
% hObject    handle to parreceditP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parreceditP as text
%        str2double(get(hObject,'String')) returns contents of parreceditP as a double


% --- Executes on button press in parrecbuttonP.
function parrecbuttonP_Callback(hObject, eventdata, handles)
% hObject    handle to parrecbuttonP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% s = pwd;
% cd(handles.PARPATH);
[filename, pathname] = uigetfile2({'*.PAR','Par Files (*.PAR)';'*.REC','Rec Files (*.REC)'; ...
        '*.*','All Files (*.*)'}, 'Select a Par file');
if filename == 0
    return
else
    set (handles.parreceditP,'String',[pathname,filename]);
    guidata(hObject,handles);
end
% cd(s);


% --- Executes during object creation, after setting all properties.
function parreceditS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parreceditS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function parreceditS_Callback(hObject, eventdata, handles)
% hObject    handle to parreceditS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parreceditS as text
%        str2double(get(hObject,'String')) returns contents of parreceditS as a double


% --- Executes on button press in parrecbuttonS.
function parrecbuttonS_Callback(hObject, eventdata, handles)
% hObject    handle to parrecbuttonS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% s = pwd;
% cd(handles.PARPATH);
[filename, pathname] = uigetfile2({'*.PAR','Par Files (*.PAR)';'*.REC','Rec Files (*.REC)'; ...
        '*.*','All Files (*.*)'}, 'Select a Par file');
if filename == 0
    return
else
    set (handles.parreceditS,'String',[pathname,filename]);
    guidata(hObject,handles);
end
% cd(s);


% --- Executes on button press in retrievebutton.
function retrievebutton_Callback(hObject, eventdata, handles)
% hObject    handle to retrievebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = get (handles.parreceditM,'String');
[pathname, name] = FindName(filename);
[a,b,c]=imgRecon_parrec(filename);
set (handles.nXedit,'String',c(1));
set (handles.nYedit,'String',c(2));
set (handles.nSedit,'String',c(3));
set (handles.nPhedit,'String',c(7));

% Load Magnitude
fname(1,:) = get (handles.parreceditM,'String');
temp1 = get (handles.parreceditP,'String');
fname(2,1:length(temp1)) = temp1;
temp2 = get (handles.parreceditS,'String');
fname(3,1:length(temp2)) = temp2;
fletter = 'MPS';

for i=1:3
    if isempty(fname(i,:)) == 1
        errordlg(['Please specify the par/rec file in ', fletter(i),' direction.']);
        return;
    else
        temp = deblank(fname(i,:));
        [a,b,c]=imgRecon_parrec(temp(1:length(temp)));
        MagIm(:,:,:,i) = mean(a(:,:,:,1,1,1,:),7);
    end
end

MagIm = mean(MagIm,4);

name1 = 'MagIm.mat';
save([pathname,name1],'MagIm','-v6');
set (handles.MagImedit,'String',[pathname,name1]);


% --- Executes during object creation, after setting all properties.
function nXedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nXedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nXedit_Callback(hObject, eventdata, handles)
% hObject    handle to nXedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nXedit as text
%        str2double(get(hObject,'String')) returns contents of nXedit as a double


% --- Executes during object creation, after setting all properties.
function nYedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nYedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nYedit_Callback(hObject, eventdata, handles)
% hObject    handle to nYedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nYedit as text
%        str2double(get(hObject,'String')) returns contents of nYedit as a double


% --- Executes during object creation, after setting all properties.
function nSedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nSedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nSedit_Callback(hObject, eventdata, handles)
% hObject    handle to nSedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nSedit as text
%        str2double(get(hObject,'String')) returns contents of nSedit as a double


% --- Executes during object creation, after setting all properties.
function nPhedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nPhedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function nPhedit_Callback(hObject, eventdata, handles)
% hObject    handle to nPhedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nPhedit as text
%        str2double(get(hObject,'String')) returns contents of nPhedit as a double


% --- Executes during object creation, after setting all properties.
function MagImedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MagImedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function MagImedit_Callback(hObject, eventdata, handles)
% hObject    handle to MagImedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MagImedit as text
%        str2double(get(hObject,'String')) returns contents of MagImedit as a double



% --- Executes on button press in resetallbutton.
function resetallbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetallbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetpart1(handles);
resetpart2(handles);
resetpart3(handles);


% --- Executes on button press in closebutton.
function closebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcbf);  % Close GUI


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Unwrapping
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in NoUnwrap.
function NoUnwrap_Callback(hObject, eventdata, handles)
% hObject    handle to NoUnwrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NoUnwrap

temp = get(handles.NoUnwrap,'Value');
if temp==1
    set (handles.NeedUnwrap,'Value',0);
end


% --- Executes on button press in NeedUnwrap.
function NeedUnwrap_Callback(hObject, eventdata, handles)
% hObject    handle to NeedUnwrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NeedUnwrap

temp = get(handles.NeedUnwrap,'Value');
if temp==1
    set (handles.NoUnwrap,'Value',0);
end


% --- Executes during object creation, after setting all properties.
function Maskedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Maskedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Maskedit_Callback(hObject, eventdata, handles)
% hObject    handle to Maskedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Maskedit as text
%        str2double(get(hObject,'String')) returns contents of Maskedit as a double


% --- Executes on button press in Maskbutton.
function Maskbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Maskbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% s = pwd;
% cd(handles.PARPATH);
[filename, pathname] = uigetfile2({'*.mat','Mask Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select a mask file');
if filename == 0
    return
else
    set (handles.Maskedit,'String',[pathname,filename]);
    guidata(hObject,handles);
end
% cd(s);


% --- Executes on button press in resetbutton1.
function resetbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to resetbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetpart2(handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Motion Reconstruction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in CheckFull.
function CheckFull_Callback(hObject, eventdata, handles)
% hObject    handle to CheckFull (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckFull

temp = get(handles.CheckFull,'Value');
if temp==1
    set (handles.CheckLess,'Value',0);
end


% --- Executes on button press in CheckLess.
function CheckLess_Callback(hObject, eventdata, handles)
% hObject    handle to CheckLess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckLess

temp = get(handles.CheckLess,'Value');
if temp==1
    set (handles.CheckFull,'Value',0);
end


% --- Executes during object creation, after setting all properties.
function PatternEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PatternEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function PatternEdit_Callback(hObject, eventdata, handles)
% hObject    handle to PatternEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PatternEdit as text
%        str2double(get(hObject,'String')) returns contents of PatternEdit as a double



% --- Executes on button press in procbutton.
function procbutton_Callback(hObject, eventdata, handles)
% hObject    handle to procbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = get(handles.parreceditM,'String');
[pathname, name] = FindName(filename);
[a,b,c]=imgRecon_parrec(filename);
nX = c(1);
nY = c(2);
nS = c(3);
nPh = c(7);
fatS = get(handles.Fatshift,'String');
if isempty(fatS) == 1
    DirIndex = DirRead(b);
else
    DirIndex = DirRead(b,fatS);
end
% DirIndex = DirRead(b);
freqHz = get(handles.Freq,'String');
freqHz = str2num(freqHz);

% Get Unwrapping parameters
UnwrapFlag = 0;
NoUnwrap = get(handles.NoUnwrap,'Value');
NeedUnwrap = get(handles.NeedUnwrap,'Value');
if NoUnwrap==1
    UnwrapFlag = 0;  %% No unwrapping
    Maskedit = get(handles.Maskedit,'String');
elseif NeedUnwrap==1
    UnwrapFlag = 1;
    Maskedit = get(handles.Maskedit,'String');
end    
if isempty(Maskedit) == 0
    h = load(Maskedit);
    mlen = size(h.mask);
    
    % Update added by Matt McGarry, 27 jun 2010
    % Dilate mask for unwrapping, smoothing of the surface mesh results in a
    % shifting of some nodes, which can result in the zero values outside
    % the mask being used during interpolations of the motions, leading to
    % boundary errors. Slice direction is OK, only x and y directions are a
    % problem.
    SE=strel(ones(7,7));
    for ii=1:size(h.mask,3)
        h.mask(:,:,ii)=imdilate(h.mask(:,:,ii),SE);
    end   
    
    if length(mlen)==2
        mask = repmat(h.mask,[1 1 nS]);
    elseif length(mlen)==3
        mask = h.mask;
    else
        mask = ones(nX,nY,nS);
    end
else
    mask = ones(nX,nY,nS);
end


% Get WinVector
CheckFull = get(handles.CheckFull,'Value');
CheckLess = get(handles.CheckLess,'Value');
WinPat = get(handles.PatternEdit,'String');
if  CheckFull==1 && CheckLess ==0
    WinVector = 1:nPh;
elseif CheckFull==0 && CheckLess ==1 && isempty(WinPat) == 0
    WinVector = str2num(WinPat);
elseif CheckFull==0 && CheckLess ==1 && isempty(WinPat) == 1
    errordlg('Please specify the combination vector.');
    return;
end


% Get other saving choices
SaveRaw = get(handles.SaveRaw,'Value');
SaveError = get(handles.SaveError,'Value');


% Start reconstruction
fname(1,:) = get (handles.parreceditM,'String');
temp1 = get (handles.parreceditP,'String');
fname(2,1:length(temp1)) = temp1;
temp2 = get (handles.parreceditS,'String');
fname(3,1:length(temp2)) = temp2;
fletter = 'MPS';

tv1=tic;
matlabpool('open',8);
for i=1:3
     if isempty(fname(i,:)) == 1
         errordlg(['Please specify the par/rec file in ', fletter(i),' direction.']);
         return;
     else
        disp(['Reconstruct direction ',num2str(i),':']);
        temp = deblank(fname(i,:));
        [a,b,c]=imgRecon_parrec(temp(1:length(temp)));
        MagIm(:,:,:,i) = mean(a(:,:,:,1,1,1,:),7);
        clear Gcim;
        if c(6)==2
            Gcim(:,:,:,:) = a(:,:,:,1,1,2,:);
        elseif c(6)==4
            Gcim(:,:,:,:) = angle(a(:,:,:,1,1,2,:) + 1i*a(:,:,:,1,1,3,:));
            %Gcim(:,:,:,:) = a(:,:,:,1,1,4,:);
        end
		Gcim = permute(Gcim,[1 2 4 3]);
        Gcim = BlockUnwrapping(Gcim,mask,UnwrapFlag);
		[A(:,:,:,i), P(:,:,:,i), ErrorMap(:,:,:,i), FPower(:,:,:,:,i)] = FFTLessGen(Gcim, WinVector);
        
        % Generate Errormap using propogation of errors analysis        
        
        if(CheckFull==1 && CheckLess ==0) % Using full set of phase offsets
            mask_air=AirMask(a);
            b=a;
            [stdr_m,stdi_m]=Noise_ParRec(b,mask_air);
            if(size(a,6)==2)
                tmpM(:,:,:,:)=a(:,:,:,1,1,1,:);
            else
                tmpM(:,:,:,:)=abs(a(:,:,:,1,1,2,:) + 1i.*a(:,:,:,1,1,3,:));
            end
            %                           phstoMotion      realimagtophs      realandimagerror
            ErrorMapPropofErrs(:,:,:,i)=sqrt(2/nPh)  .*  1./mean(tmpM,4)  .*  mean([stdr_m stdi_m]);
            clear tmpM
        else
            warning('ErrorMapPropofErrs Not Configured for Reduced Motion Encoding')
            ErrorMapPropofErrs=false;
        end
                
        if SaveRaw==1
            save([pathname,'Raw',fletter(i),'.mat'], 'Gcim','-v6');
        end
     end
end
matlabpool close
tv2=toc(tv1);
disp(['Unwrapping time:' num2str(tv2) ' seconds'])

MagIm = mean(MagIm,4);
maskall = repmat(mask,[1 1 1 3]);

if SaveError==1
    PropErrsInfo.type='Prop of Errors, Matt Mcgarry Mar 28 2011.'; 
    PropErrsInfo.explanation='Calculated from std dev of air in real and imag parts, then std(A)(i,j,k) = std_air * 1/Magn(ii,jj,kk) * sqrt(2/N) ';
    ErrorMap = ErrorMap.*maskall;
    stdform=true; % Confirms the ErrorMap is calcualted using std(misfit) rather than mean(abs(misfit))
    % Create ErrorMap Note
    NoteOnErrorMap = 'ErrorMap is the standard deviation of the misfits, and must be multiplied by sqrt(2/Nph) to give the uncertianty in the motion amplitude';
    NoteOnErrorMapPropofErrors = 'ErrorMapPropofErrs is the uncertianty in the amplitude, and relies on Mask_Air correctly masking a region of air in the MR image. Mask_Air is generated Automatically, you need to check it';
    save([pathname,'ErrorMap.mat'], 'ErrorMap','FPower','stdform','ErrorMapPropofErrs','PropErrsInfo','NoteOnErrorMap','NoteOnErrorMapPropofErrors','-v6');
    
end

name1 = 'MRE_3DMotionData.mat';
A = A.*maskall;
P = P.*maskall;

save([pathname,name1],'MagIm','A','P','fatS','-v6');
name2 = 'HeaderData.mat';
save([pathname,name2],'DirIndex','freqHz','-v6');
set (handles.SaveMotionEdit,'String',[pathname,name1]);
disp('The motion reconstruction is done!');
delete 'lastUsedDir.mat'
% guidata(hObject,handles);


cdir = pwd;
ind = findstr('/',cdir);
fname = cdir(ind(end)+1:end);

inputfile='input';
fid=fopen(inputfile,'w');
fprintf(fid,['3\n']);
fprintf(fid,[fname '\n']);
fprintf(fid,['0.002\n']);
fprintf(fid,['ligin.m.solamen.th@dartmouth.edu\n']);
fprintf(fid,['0.85d0\n']);
fprintf(fid,['100\n']);
fprintf(fid,['1d-4\n']);
fprintf(fid,['32\n']);

% --- Executes during object creation, after setting all properties.
function SaveMotionEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveMotionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function SaveMotionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to SaveMotionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveMotionEdit as text
%        str2double(get(hObject,'String')) returns contents of SaveMotionEdit as a double


% --- Executes on button press in SaveRaw.
function SaveRaw_Callback(hObject, eventdata, handles)
% hObject    handle to SaveRaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveRaw


% --- Executes on button press in SaveError.
function SaveError_Callback(hObject, eventdata, handles)
% hObject    handle to SaveError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveError



% --- Executes on button press in resetbutton2.
function resetbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to resetbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetpart3(handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function resetpart1(handles)
% Reset all the items on panel one.

set (handles.parreceditM,'String','');
set (handles.parreceditP,'String','');
set (handles.parreceditS,'String','');
set (handles.MagImedit,'String','');
set (handles.nXedit,'String','');
set (handles.nYedit,'String','');
set (handles.nSedit,'String','');
set (handles.nPhedit,'String','');


function resetpart2(handles)
% Reset all the items on panel two.

set (handles.NoUnwrap,'Value',1);
set (handles.NeedUnwrap,'Value',0);
set (handles.Maskedit,'String','');


function resetpart3(handles)
% Reset all the items on panel three.

set (handles.CheckFull,'Value',1);
set (handles.CheckLess,'Value',0);
set (handles.SaveRaw,'Value',0);
set (handles.SaveError,'Value',0);

set (handles.PatternEdit,'String','');
set (handles.SaveMotionEdit,'String','');
set (handles.Freq,'String','');
set (handles.Fatshift,'String','');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Save data to the rawdata directory
% function [pathname, name] = FindName(filename)
% % function [pathname, name] = FindName(filename,filesuffix);
% % filename   starting file name from a list of files that need to be read
% % filesuffix the filefuffix to be saved
% % DataMtr    data matrix to be saved
% % handles    structure with handles and user data (see GUIDATA)
% 
% a = find(filename=='\');
% if isempty(a)
%     a = find(filename=='/');
% end
% name = filename(max(a)+1:length(filename));
% pathname = filename(1:max(a));
% % b = find(filenamesh=='_');
% % name = [filenamesh(1:b(1)-1),filesuffix,'.mat'];

% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Unwrap the raw data
% function  UGcim = BlockUnwrapping(Gcim,mask,UnwrapFlag)
% % The function unwraps 4D block of raw data for one direction.
% 
% if UnwrapFlag == 0
%     UGcim = Gcim;     return;
% end
% 
% nS = size(Gcim,4);
% for j=1:nS
%     UGcim(:,:,:,j) = Qual3DUnwrap(Gcim(:,:,:,j),mask(:,:,j));
%     disp([num2str(j*100/nS),'% has been finished!']);
% end
% 



function Freq_Callback(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq as text
%        str2double(get(hObject,'String')) returns contents of Freq as a double


% --- Executes during object creation, after setting all properties.
function Freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function fatshift_Callback(hObject, eventdata, handles)
% hObject    handle to fatshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fatshift as text
%        str2double(get(hObject,'String')) returns contents of fatshift as a double


% --- Executes during object creation, after setting all properties.
function fatshift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fatshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Fatshift_Callback(hObject, eventdata, handles)
% hObject    handle to Fatshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fatshift as text
%        str2double(get(hObject,'String')) returns contents of Fatshift as a double


% --- Executes during object creation, after setting all properties.
function Fatshift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fatshift (see GCBO)
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

