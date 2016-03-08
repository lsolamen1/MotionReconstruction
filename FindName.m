%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save data to the rawdata directory
function [pathname, name] = FindName(filename)
% function [pathname, name] = FindName(filename,filesuffix);
% filename   starting file name from a list of files that need to be read
% filesuffix the filefuffix to be saved
% DataMtr    data matrix to be saved
% handles    structure with handles and user data (see GUIDATA)

a = find(filename=='\');
if isempty(a)
    a = find(filename=='/');
end
name = filename(max(a)+1:length(filename));
pathname = filename(1:max(a));
% b = find(filenamesh=='_');
% name = [filenamesh(1:b(1)-1),filesuffix,'.mat'];
