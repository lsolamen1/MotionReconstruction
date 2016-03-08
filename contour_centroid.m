%   PHILLIP R PERRINEZ
%   Ph.D. Candidate
%   Dartmouth College
%   December 2007

%   CONTOUR_CENTROID.M

function [c]=contour_centroid(co,d)

nn = length(co);

dx = zeros(nn,1);
dy = zeros(nn,1);
r = zeros(nn,1);

x = co(:,1);
y = co(:,2);

[cnx,cny] = centroid(x,y);

for i = 1:nn
    dx(i) = cnx-x(i);
    dy(i) = cny-y(i);
    r(i)  = sqrt(dx(i)^2 + dy(i)^2);
end

dx = dx./r;
dy = dy./r;

c = [x+dx*d y+dy*d];

disp('done');