function [x,y,w,h] = convert( bbox,size )
   
    dw = 1./size(2);
    dh = 1./size(1);
    
    x = (bbox.xmin+bbox.w/2)*dw;
    y = (bbox.ymin+bbox.h/2)*dh;
    w = bbox.w*dw;
    h = bbox.h*dh;
    
end

