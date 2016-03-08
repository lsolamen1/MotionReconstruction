function r = Grad(p1,p2)

r = p1 - p2;

% while (r>=pi)
%     r = r - 2*pi;
% end
% while (r<-pi)
%     r = r + 2*pi;
% end

r = mod(r,2*pi);
if (r>pi) 
    r = r - 2*pi;
elseif (r<-pi)
    r = r + 2*pi;
end
